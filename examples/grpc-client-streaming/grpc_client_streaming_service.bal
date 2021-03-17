// This is the server implementation of the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function lotsOfGreetings(stream<string, grpc:Error> clientStream)
                                    returns string|error {
        log:printInfo("Connected sucessfully.");
        // Read and process each message in the client stream.
        error? e = clientStream.forEach(isolated function(string name) {
            log:printInfo("Greet received: " + name);
        });
        // Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream.
        if (e is grpc:EOS) {
            return "Ack";
        }
        return "";
    }
}
