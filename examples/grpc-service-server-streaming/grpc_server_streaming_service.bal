import ballerina/grpc;

@grpc:Descriptor {
    value: GRPC_SERVER_STREAMING_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function lotsOfReplies(string name) returns stream<string, error?> {
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
