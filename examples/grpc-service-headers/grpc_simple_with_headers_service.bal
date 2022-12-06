import ballerina/grpc;
import ballerina/log;
import ballerina/protobuf.types.wrappers;

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function hello(wrappers:ContextString request) returns wrappers:ContextString|error {
        // Reads the request message and creates a response.
        string message = "Hello " + request.content;

        // Reads the header value in the request message by passing the request header
        // map and header key.
        string reqHeader = check grpc:getHeader(request.headers, "client_header_key");
        log:printInfo("Server received header value: " + reqHeader);

        // Sends the response with the header.
        return {content: message, headers: {server_header_key: "Response Header value"}};
    }
}
