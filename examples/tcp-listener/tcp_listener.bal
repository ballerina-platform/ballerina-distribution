import ballerina/io;
import ballerina/log;
import ballerina/tcp;

// Bind the service to the port. 
service on new tcp:Listener(3000) {

    // This remote method is invoked when the new client connects to the server.
    remote function onConnect(tcp:Caller caller)
                              returns tcp:ConnectionService {
        io:println("Client connected to echo server: ", caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {
    *tcp:ConnectionService;

    // This remote method is invoked once the content is received from the client.
    remote function onBytes(tcp:Caller caller, readonly & byte[] data) 
        returns tcp:Error? {
        io:println("Echo: ", string:fromBytes(data));
        // Echoes back the data to the client from which the data is received.
        return caller->writeBytes(data);
    }

    // This remote method is invoked in an erroneous situation,
    // which occurs during the execution of the `onConnect` or `onBytes` method.
    remote function onError(tcp:Error err) {
        log:printError("An error occurred", 'error = err);
    }

    // This remote method is invoked when the connection is closed.
    remote function onClose() {
        io:println("Client left");
    }
}
