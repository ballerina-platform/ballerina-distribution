// This is the Ballerina test for simple RPC with headers scenario.
import ballerina/grpc;
import ballerina/test;

// Client endpoint configuration
HelloWorldClient clientEp = check new("http://localhost:9090");

@test:Config
function testSimpleServiceWithHeaders() returns error? {
    // Create request message with header value.
    ContextString requestMessage =
    {content: "WSO2", headers: {client_header_key: "0987654321"}};

    // Execute a simple remote call.
    ContextString result = check ep->helloContext(requestMessage);

    // Read content in the response message
    string expected = "Hello WSO2";
    test:assertEquals(result.content, expected);

    // Read header value in the response message
    string headerValue = check grpc:getHeader(result.headers, "server_header_key");
    string expectedHeaderValue = "Response Header value";
    test:assertEquals(headerValue, expectedHeaderValue);
}
