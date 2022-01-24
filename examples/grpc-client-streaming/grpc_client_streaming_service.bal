// This is the server implementation of the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_CLIENT_STREAMING,
    descMap: getDescriptorMapGrpcClientStreaming()
}
service "HelloWorld" on new grpc:Listener(9090) {
    isolated remote function lotsOfGreetings(
                            stream<string, error?> clientStream)
                            returns string|error {
        log:printInfo("Client connected successfully.");
        // Reads and processes each message in the client stream.
        _ = check from string name in clientStream
            do {
                log:printInfo(string `Greet received: ${name}`);
            };
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        return "Ack";
    }
}
