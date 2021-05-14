// This is the client implementation of the bidirectional streaming scenario.
import ballerina/io;

// Creates a gRPC client to interact with the remote server.
ChatClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Executes the RPC call and receives the customized streaming client.
    ChatStreamingClient streamingClient = check ep->chat();

    // Reads server responses in another strand.
    future<error?> f1 = start readResponse(streamingClient);

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

function readResponse(ChatStreamingClient streamingClient) returns error? {
    // Receives the server stream response iteratively.
    string? result = check streamingClient->receiveString();
    while !(result is ()) {
        io:println(result);
        result = check streamingClient->receiveString();
    }
}
