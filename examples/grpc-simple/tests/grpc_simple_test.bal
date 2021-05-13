// This is the Ballerina test for grpc simple scenario.
import ballerina/test;

// Client endpoint configuration
HelloWorldClient clientEp = check new("http://localhost:9090");

@test:Config
function testSimpleService() returns error? {
    // Execute a simple remote call.
    string result = check clientEp->hello("WSO2");
    string expected = "Hello WSO2";
    test:assertEquals(result, expected);
}
