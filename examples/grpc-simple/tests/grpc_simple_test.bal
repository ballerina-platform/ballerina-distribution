// This is the Ballerina test for the simple GRPC scenario.
import ballerina/test;

// Client endpoint configuration.
HelloWorldClient clientEp = check new("http://localhost:9090");

@test:Config
function testSimpleService() returns error? {
    // Executes a simple remote call.
    string result = check clientEp->hello("WSO2");
    string expected = "Hello WSO2";
    test:assertEquals(result, expected);
}
