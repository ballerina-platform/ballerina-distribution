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

public client class ChatClient {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public isolated function init(string url,
    grpc:ClientConfiguration? config = ()) returns grpc:Error? {
        // Initialize the client endpoint.
        self.grpcClient = check new(url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR,
        getDescriptorMap());
    }

    isolated remote function chat() returns (ChatStreamingClient|grpc:Error) {
        grpc:StreamingClient sClient = check
        self.grpcClient->executeBidirectionalStreaming("Chat/chat");
        return new ChatStreamingClient(sClient);
    }
}

public client class ChatStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendChatMessage(ChatMessage message) returns
    grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextChatMessage(ContextChatMessage message)
    returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error {
        [anydata, map<string|string[]>] [payload, headers] =
        check self.sClient->receive();
        return payload.toString();
    }

    isolated remote function receiveContextString() returns
    ContextString|grpc:Error {
        [anydata, map<string|string[]>] [payload, headers] =
        check self.sClient->receive();
        return {content: payload.toString(), headers: headers};
    }

    isolated remote function sendError(grpc:Error response) returns
    grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

// The context record includes the message payload and headers.
public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};

// The context record includes the message payload and headers.
public type ContextChatMessage record {|
    ChatMessage content;
    map<string|string[]> headers;
|};

public type ChatMessage record {|
    string name = "";
    string message = "";
|};

