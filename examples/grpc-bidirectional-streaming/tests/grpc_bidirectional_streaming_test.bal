// This is the Ballerina test for bidirectional streaming scenario.
import ballerina/test;

//Client endpoint configuration.
ChatClient chatEp = check new("http://localhost:9090");

@test:Config
function testBidiStreamingService() returns error? {
        // Executes the RPC call and receives the customized streaming client.
        ChatStreamingClient streamingClient = check chatEp->chat();

        // Reads the server responses in another strand.
        future<error?> f1 = start readResponseTest(streamingClient);

        // Sends multiple messages to the server.
        ChatMessage[] messages = [
            {name: "Sam", message: "Hi"},
            {name: "Ann", message: "Hey"},
            {name: "John", message: "Hello"}
        ];
        foreach ChatMessage msg in messages {
            check streamingClient->sendChatMessage(msg);
        }
        // Once all the messages are sent, the client sends the message to notify the server about the completion.
        check streamingClient->complete();

        // Waits until all server messages are received.
        check wait f1;
}

function readResponseTest(ChatStreamingClient streamingClient) returns error? {
    string expectedMsg1 = "Sam: Hi";
    string expectedMsg2 = "Ann: Hey";
    string expectedMsg3 = "John: Hello";
    // Receives the server stream response iteratively.
    string? result = check streamingClient->receiveString();
    while !(result is ()) {
        test:assertTrue(result == expectedMsg1 || result == expectedMsg2 || result == expectedMsg3);
        result = check streamingClient->receiveString();
    }
}
