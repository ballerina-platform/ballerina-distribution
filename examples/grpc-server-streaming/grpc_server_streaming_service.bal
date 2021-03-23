// This is the server implementation of the server streaming scenario.
import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function lotsOfReplies(string name)
                        returns stream<string, error|never>|error {
        log:printInfo("Server received hello from " + name);
        string[] greets = ["Hi", "Hey", "GM"];
        // Create the array of responses by appending the received name.
        int i = 0;
        foreach string greet in greets {
            greets[i] = greet + " " + name;
            i += 1;
        }
        // Return the stream of strings back to the client.
        return greets.toStream();
    }
}
