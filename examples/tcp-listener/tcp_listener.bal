import ballerina/io;
import ballerina/log;
import ballerina/tcp;

// Bind the service to the port. 
service on new tcp:Listener(3000) {

    // This remote method is invoked when the new client joins the server.
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("Client connected to echoServer: ", caller.remotePort);
        return new EchoService(caller);
    }
}

service class EchoService {
    tcp:Caller caller;

    public function init(tcp:Caller c) {
        self.caller = c;
    }

    // This remote method is invoked once the content is received from the client.
    remote function onBytes(readonly & byte[] data) returns tcp:Error? {
        io:println("Echo: ", string:fromBytes(data));
        // Echo back the data to the same client which the data received from.
        check self.caller->writeBytes(data);
    }

    // This remote method is invoked in an error situation
    // if it happens during the `onConnect` and `onBytes` methods.
    remote function onError(readonly & tcp:Error err) returns tcp:Error? {
        log:printError("An error occurred", err = err);
    }

    // This remote method is invoked when the connection is closed.
    remote function onClose() returns tcp:Error? {
        io:println("Client left: ", self.caller.remoteHost, "/",
            self.caller.remotePort);
    }
}

