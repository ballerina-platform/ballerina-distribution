// This is the server implementation of the server streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_SERVER_STREAMING,
    descMap: getDescriptorMapGrpcServerStreaming()
}
service "HelloWorld" on new grpc:Listener(9090) {
    remote function lotsOfReplies(string name)
                        returns stream<string, error?>|error {
        log:printInfo("Server received hello from " + name);
        string[] greets = ["Hi", "Hey", "GM"];
        // Creates the array of responses by appending the received name.
        int i = 0;
        foreach string greet in greets {
            greets[i] = greet + " " + name;
            i += 1;
        }
        // Returns the stream of messages back to the client.
        return greets.toStream();
    }
}
