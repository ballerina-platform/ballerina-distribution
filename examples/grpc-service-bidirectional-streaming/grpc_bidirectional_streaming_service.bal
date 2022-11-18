// This is the server implementation of the bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:Descriptor {
    value: GRPC_BIDIRECTIONAL_STREAMING_DESC
}
service "Chat" on new grpc:Listener(9090) {
    // The generated code of the Ballerina gRPC command does not contain ChatStringCaller.
    // To show the usage of a caller, this RPC call uses a caller to send messages to the client.
    isolated remote function chat(ChatStringCaller caller,
                    stream<ChatMessage, error?> clientStream) {
        // Reads and processes each message in the client stream.
        do {
            _ = check from ChatMessage chatMsg in clientStream
                do {
                    checkpanic caller->sendString(string `${chatMsg.name}: ${chatMsg.message}`);
                };
            // Once the client sends a notification to indicate the end of the stream,
            // '()' is returned by the stream.
            check caller->complete();
        } on fail error err {
            log:printError("The connection is closed with an error.", 'error = err);
        }
    }
}
