// This is the server implementation of the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on new grpc:Listener(9090) {
    remote function lotsOfGreetings(stream<string, grpc:Error?> clientStream)
                                    returns string|error {
        log:printInfo("Client connected successfully.");
        // Read and process each message in the client stream.
        error? e = clientStream.forEach(isolated function(string name) {
            log:printInfo("Greet received: " + name);
        });
        // Once the client sends a notification to indicate the end of the stream, '()' is returned by the stream.
        if (e is ()) {
            return "Ack";
        } else {
            //If the client sends an error to the server, the stream closes and returns the error
            log:printError("Connection is closed by the client with Error",
                'error = e);
            return "";
        }
    }
}
