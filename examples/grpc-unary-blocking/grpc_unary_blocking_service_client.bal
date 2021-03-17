// This is client implementation for unary blocking scenario.
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    HelloWorldClient ep = check new("http://localhost:9090");
    // Setting the custom headers.
    ContextString requestMessage =
    {content: "WSO2", headers: {client_header_key: "0987654321"}};
    // Executing the unary call.
    ContextString result = check ep->helloContext(requestMessage);
    // Print the content.
    io:println(result.content);
    // Print a header value.
    io:println(check grpc:getHeader(result.headers, "server_header_key"));
}
