import ballerina/grpc;
import ballerina/log;

@grpc:Descriptor {
    value: GRPC_CLIENT_STREAMING_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {

    remote function lotsOfGreetings(stream<string, error?> clientStream)
                        returns string {
        // Reads and processes each message in the client stream.
        error? result = from string name in clientStream
            do {
                log:printInfo(string `Greet received: ${name}`);
            };

        if (result is error) {
            // Client closes the connection with an error.
            log:printError("The connection is closed with an error.", 'error = result);
        }
        // Once the client sends a notification to indicate the end of the stream,
        // '()' is returned by the stream.
        return "Ack";
    }
}
