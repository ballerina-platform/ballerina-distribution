// This is the client implementation of the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    // Client endpoint configuration.
    ChatClient ep = check new("http://localhost:9090");
    // Executes the RPC call and receives the customized streaming client.
    ChatStreamingClient streamingClient = check ep->chat();

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
    // Receives the server stream response iteratively.
    var result = streamingClient->receiveString();
    while !(result is grpc:EOS) {
        if !(result is grpc:Error) {
            io:println(result);
        }
        result = streamingClient->receiveString();
    }
}
