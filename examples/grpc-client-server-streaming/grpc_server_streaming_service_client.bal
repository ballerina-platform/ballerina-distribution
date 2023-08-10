import ballerina/grpc;
import ballerina/io;

public function main() returns error? {
    // Creates a gRPC client to interact with the remote server.
    HelloWorldClient ep = check new ("http://localhost:9090");

    // Executes the streaming RPC call and gets the response as a stream.
    stream<string, grpc:Error?> result = check ep->lotsOfReplies("WSO2");
    // Iterates through the stream and prints the content.
    check result.forEach(function(string str) {
        io:println(str);
    });
}
