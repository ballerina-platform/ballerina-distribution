// This is the client implementation of the simple RPC scenario.
import ballerina/grpc;
import ballerina/io;
import ballerina/protobuf.types.wrappers;

// Creates a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Creates the request message with the header value.
    wrappers:ContextString requestMessage =
    {content: "WSO2", headers: {client_header_key: "0987654321"}};

    // Executes a simple remote call.
    wrappers:ContextString result = check ep->helloContext(requestMessage);

    // Prints the received result.
    io:println(result.content);

    // Reads the header value in the response message and prints it.
    io:println(check grpc:getHeader(result.headers, "server_header_key"));
}
