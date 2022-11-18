// This is the client implementation of the simple RPC scenario.
import ballerina/io;

public function main() returns error? {
    // Creates a gRPC client to interact with the remote server.
    HelloWorldClient ep = check new ("http://localhost:9090");

    // Executes a simple remote call.
    string result = check ep->hello("WSO2");
    // Prints the received result.
    io:println(result);
}
