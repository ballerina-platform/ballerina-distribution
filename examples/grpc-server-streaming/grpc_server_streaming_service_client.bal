// This is the client implementation for the server streaming scenario.
import ballerina/grpc;
import ballerina/io;

// Create a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Execute the streaming RPC call and gets the response as a stream.
    stream<string, grpc:Error?> result = check ep->lotsOfReplies("WSO2");
    // Iterate through the stream and print the content.
    check result.forEach(function(string str) {
        io:println(str);
    });
}
