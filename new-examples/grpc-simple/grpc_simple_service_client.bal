// This is the client implementation of the simple RPC scenario.
import ballerina/io;

// Creates a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Executes a simple remote call.
    string result = check ep->hello("WSO2");
    // Prints the received result.
    io:println(result);
}
