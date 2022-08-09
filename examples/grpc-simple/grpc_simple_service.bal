// This is the server implementation of the simple RPC scenario.
import ballerina/grpc;

@grpc:ServiceDescriptor {
    descriptor: GRPC_SIMPLE_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function hello(string request) returns string|error {
        // Reads the request message and sends a response.
        return "Hello " + request;
    }
}
