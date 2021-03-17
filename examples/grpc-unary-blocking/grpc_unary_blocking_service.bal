// This is the server implementation of the unary blocking/unblocking scenario.
import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function hello(ContextString request) returns ContextString|error {
        log:printInfo("Invoked the hello RPC call.");
        // Reads the request content.
        string message = "Hello " + request.content;

        // Reads custom headers in request message.
        string reqHeader = check grpc:getHeader(request.headers,
        "client_header_key");
        log:printInfo("Server received header value: " + reqHeader);

        // Sends response with custom headers.
        return {content: message, headers: {server_header_key:
        "Response Header value"}};
    }
}
