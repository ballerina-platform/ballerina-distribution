// This is the server implementation of the bidirectional streaming scenario.
import ballerina/grpc;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_BIDIRECTIONAL_STREAMING,
    descMap: getDescriptorMapGrpcBidirectionalStreaming()
}
service "Chat" on new grpc:Listener(9090) {
    // The generated code of the Ballerina gRPC command does not contain ChatStringCaller.
    // To show the usage of a caller, this RPC call uses a caller to send messages to the client.
    remote function chat(ChatStringCaller caller,
                    stream<ChatMessage, error?> clientStream) returns error? {
        // Reads and processes each message in the client stream.
        check clientStream.forEach(function(ChatMessage chatMsg) {
            checkpanic caller->sendString(
                                string `${chatMsg.name}: ${chatMsg.message}`);
        });
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        check caller->complete();
    }
}
