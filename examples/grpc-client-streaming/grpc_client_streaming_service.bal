// This is the server implementation of the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_CLIENT_STREAMING,
    descMap: getDescriptorMapGrpcClientStreaming()
}
service "HelloWorld" on new grpc:Listener(9090) {
    remote function lotsOfGreetings(stream<string, grpc:Error?> clientStream)
                                    returns string|error {
        log:printInfo("Client connected successfully.");
        // Reads and processes each message in the client stream.
        check clientStream.forEach(isolated function(string name) {
            log:printInfo("Greet received: " + name);
        });
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        return "Ack";
    }
}
