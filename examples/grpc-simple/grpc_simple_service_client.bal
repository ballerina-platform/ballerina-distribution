// This is the client implementation for simple RPC scenario.
import ballerina/io;

// Create a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Execute a simple remote call.
    string result = check ep->hello("WSO2");
    // Print the received result.
    io:println(result);
}
