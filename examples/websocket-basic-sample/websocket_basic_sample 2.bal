import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/websocket;

string ping = "ping";
byte[] pingData = ping.toBytes();

@websocket:ServiceConfig {
    subProtocols: ["xml", "json"],
    idleTimeoutInSeconds: 120
}

service /basic/ws on new websocket:Listener(9090) {
   resource isolated function get .(http:Request req)
                     returns websocket:Service|websocket:Error {
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    // This `remote function` is triggered after a successful client connection.
    remote function onConnect(websocket:Caller caller) {
        io:println("\nNew client connected");
        io:println("Connection ID: " + caller.getConnectionId());
        io:println("Negotiated Sub protocol: " +
                    caller.getNegotiatedSubProtocol().toString());
        io:println("Is connection open: " + caller.isOpen().toString());
        io:println("Is connection secured: " + caller.isSecure().toString());
    }

    // This `remote function` is triggered when a new text frame is received from a client.
    remote function onString(websocket:Caller caller, string text) {
        io:println("\ntext message: " + text);
        if (text == "ping") {
            io:println("Pinging...");
            var err = caller->ping(pingData);
            if (err is websocket:Error) {
                log:printError("Error sending ping", err = err);
            }
        } else if (text == "closeMe") {
            error? result = caller->close(statusCode = 1001,
                            reason = "You asked me to close the connection",
                            timeoutInSeconds = 0);
            if (result is websocket:Error) {
                log:printError("Error occurred when closing connection",
                                err = result);
            }
        } else {
            var err = caller->writeString("You said: " + text);
            if (err is websocket:Error) {
                log:printError("Error occurred when sending text", err = err);
            }
        }
    }

    // This `remote function` is triggered when a new binary frame is received from a client.
    remote function onBinary(websocket:Caller caller, byte[] b) {
        io:println("\nNew binary message received");
        io:print("UTF-8 decoded binary message: ");
        io:println(b);
        var err = caller->writeBytes(b);
        if (err is websocket:Error) {
            log:printError("Error occurred when sending binary", err = err);
        }
    }

    // This `remote function` is triggered when a ping message is received from the client. If this remote function is not implemented,
    // a pong message is automatically sent to the connected [http:WebSocketCaller](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/clients/WebSocketCaller) when a ping is received.
    remote function onPing(websocket:Caller caller, byte[] data) {
        var err = caller->pong(data);
        if (err is websocket:Error) {
            log:printError("Error occurred when closing the connection",
                                   err = err);
        }
    }

    // This remote function is triggered when a pong message is received.
    remote function onPong(websocket:Caller caller, byte[] data) {
        io:println("Pong received");
    }

    // This remote function is triggered when a particular client reaches the idle timeout that is defined in the
    // [http:WebSocketServiceConfig](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/annotations#WebSocketServiceConfig) annotation.
    remote function onIdleTimeout(websocket:Caller caller) {
        io:println("\nReached idle timeout");
        io:println("Closing connection " + caller.getConnectionId());
        var err = caller->close(statusCode = 1001, reason =
                                    "Connection timeout");
        if (err is websocket:Error) {
            log:printError("Error occurred when closing the connection",
                               err = err);
        }
    }

    // This remote function is triggered when an error occurred in the connection or the transport.
    // This remote function is always followed by a connection closure with an appropriate WebSocket close frame
    // and this is used only to indicate the error to the user and take post decisions if needed.
    remote function onError(websocket:Caller caller, error err) {
        log:printError("Error occurred ", err = err);
    }

    // This remote function is triggered when a client connection is closed from the client side.
    remote function onClose(websocket:Caller caller, int statusCode,
                                string reason) {
        io:println(string `Client left with ${statusCode} because ${reason}`);
    }
}
