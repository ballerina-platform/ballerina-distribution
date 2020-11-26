// This is the server implementation for the unary blocking/unblocking scenario.
import ballerina/grpc;
import ballerina/log;

// Bind the `service` to the port.
@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service HelloWorld on new grpc:Listener(9090) {

    resource function hello(grpc:Caller caller, string name) {
        log:printInfo("Server received hello from " + name);
        string message = "Hello " + name;

        // Send a response message to the caller.
        grpc:Error? result = caller->send(message);
        if (result is grpc:Error) {
            log:printError("Error from Connector: " + result.message());
        }
        // Send the `completed` notification to the caller.
        result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error from Connector: " + result.message());
        }
    }
}
