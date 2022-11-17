import ballerina/grpc;

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function hello(string request) returns string|error {
        // Reads the request message and sends a response.
        return "Hello " + request;
    }
}
