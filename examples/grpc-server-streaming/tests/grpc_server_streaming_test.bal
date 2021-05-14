// This is the Ballerina test for the server streaming scenario.
import ballerina/grpc;
import ballerina/test;

// Client endpoint configuration.
HelloWorldClient streamingEp = check new("http://localhost:9090");

@test:Config
function testServerStreamingService() returns error? {
    // Executes the streaming RPC call and gets the response as a stream.
    stream<string, grpc:Error?> result = check ep->lotsOfReplies("Sam");

    string expectedMsg1 = "Hi Sam";
    string expectedMsg2 = "Hey Sam";
    string expectedMsg3 = "GM Sam";
    // Iterates through the stream and prints the content.
    check result.forEach(function(string msg) {
        test:assertTrue(msg == expectedMsg1 || msg == expectedMsg2 || msg == expectedMsg3);
    });
}
