import ballerina/http;
import ballerina/log;
import ballerina/websocket;

// The Url of the remote backend.
final string REMOTE_BACKEND = "ws://echo.websocket.org";

service /proxy/ws on new websocket:Listener(9090) {
    resource function get .(http:Request req) returns
                         websocket:Service|websocket:UpgradeError {
        return service object websocket:Service {
            websocket:Client? targetEp = ();
            // This resource gets invoked when a new client connects.
            // Since messages to the server are not read by the service until
            // the execution of the `onOpen` resource finishes, operations
            // which should happen before reading messages should be done
            // in the `onOpen` resource.
            remote function onOpen(websocket:Caller sourceEp) returns
                            websocket:Error? {
                 websocket:Client target = check new (REMOTE_BACKEND);
                 self.targetEp = target;
            }

            //This resource gets invoked upon receiving a new text message
            // from a client.
            remote function onTextMessage(websocket:Caller caller,
                                string text) returns websocket:Error? {
                websocket:Client clientEp = <websocket:Client>self.targetEp;
                var err = clientEp->writeTextMessage(text);
                if (err is websocket:Error) {
                    log:printError("Error occurred when sending text message",
                             err = err);
                }
                string resp = check clientEp->readTextMessage();
                var sourceEperr = caller->writeTextMessage(resp);
                if (err is websocket:Error) {
                    log:printError("Error occurred when sending text",
                             err = err);
                }
            }

            //This resource gets invoked when an error occurs
            // in the connection.
            remote function onError(websocket:Caller caller, error err) {
                websocket:Client clientEp = <websocket:Client>self.targetEp;
                var e = clientEp->close(statusCode = 1011,
                                reason = "Unexpected condition");
                if (e is websocket:Error) {
                    log:printError(
                        "Error occurred when closing the connection",
                        err = e);
                }
                log:printError(
                    "Unexpected error hence closing the connection",
                    err = err);
            }

            //This resource gets invoked when a client connection is closed
            // from the client side.
            remote function onClose(websocket:Caller caller, int statusCode,
                                        string reason) {
                websocket:Client clientEp = <websocket:Client>self.targetEp;
                var err = clientEp->close(statusCode = statusCode,
                           reason = reason);
                if (err is websocket:Error) {
                    log:printError(
                        "Error occurred when closing the connection",
                        err = err);
                }
            }
        };
    }
}
