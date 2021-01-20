// This is the server implementation for the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "Chat" on ep {
    remote function chat(stream<ChatMessage, error> clientStream) returns stream<string> {
        string[] responses = [];
        int i = 0;
        // Read and process each message in the client stream
        error? e = clientStream.forEach(function(anydata value) {
            ChatMessage chatMsg = <ChatMessage> value;
            responses[i] = string `${chatMsg.message}: ${chatMsg.name}`;
            i += 1;
        });
        // Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        return responses.toStream();
    }
}

public client class ChatStringCaller {
    private grpc:Caller caller;

    public function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function send(string|ContextString response) returns grpc:Error? {
        return self.caller->send(<anydata>response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}


// Context record includes message payload and headers.
public type ContextString record {|
    stream<string> content;
    map<string[]> headers;
|};

// Context record includes message payload and headers.
public type ContextChatMessage record {|
    stream<ChatMessage> content;
    map<string[]> headers;
|};

public type ChatMessage record {|
    string name = "";
    string message = "";
|};
