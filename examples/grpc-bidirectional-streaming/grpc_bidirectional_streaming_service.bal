// This is the server implementation of the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "Chat" on new grpc:Listener(9090) {
    remote function chat(stream<ChatMessage, grpc:Error?> clientStream)
                            returns stream<string, grpc:Error?> {
        log:printInfo("Invoke the chat RPC");
        string[] responses = [];
        int i = 0;
        // Read and process each message in the client stream.
        error? e = clientStream.forEach(function(ChatMessage value) {
            ChatMessage chatMsg = <ChatMessage> value;
            responses[i] = string `${chatMsg.message}: ${chatMsg.name}`;
            i += 1;
        });
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        return responses.toStream();
    }
}
