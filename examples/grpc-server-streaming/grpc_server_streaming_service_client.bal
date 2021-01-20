// This is the client implementation for the server streaming scenario.
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    // Client endpoint configuration.
    HelloWorldClient ep = check new("http://localhost:9090");
    // Execute the streaming RPC call that registers the server message listener and get the response as a stream.
    stream<anydata> result = check ep->lotsOfReplies("WSO2");
    // Iterate through the stream and print the content.
    error? e = result.forEach(function(anydata str) {
        io:println(str);
    });
}

// The client that used to invoke the RPC.
public client class HelloWorldClient {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public isolated function init(string url, grpc:ClientConfiguration? config = ()) returns grpc:Error? {
        // initialize client endpoint.
        self.grpcClient = check new(url, config);
        grpc:Error? result = self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function lotsOfReplies(string req) returns stream<anydata>|error {
        return self.grpcClient->executeServerStreaming("HelloWorld/lotsOfReplies", req);
    }

}
