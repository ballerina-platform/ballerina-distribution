// This is the client implementation for simple RPC scenario.
import ballerina/grpc;
import ballerina/io;

// Create a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Create request message with header value.
    ContextString requestMessage =
    {content: "WSO2", headers: {client_header_key: "0987654321"}};

    // Execute a simple remote call.
    ContextString result = check ep->helloContext(requestMessage);

    // Print the received result.
    io:println(result.content);

    // Read header value in the response message and print
    io:println(check grpc:getHeader(result.headers, "server_header_key"));
}
