// This is the server implementation of the simple RPC scenario.
import ballerina/grpc;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_SIMPLE,
    descMap: getDescriptorMapGrpcSimple()
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function hello(string request) returns string|error {
        // Reads the request message and sends a response.
        return "Hello " + request;
    }
}
