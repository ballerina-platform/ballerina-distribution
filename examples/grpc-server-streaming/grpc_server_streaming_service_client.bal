// This is the client implementation for the server streaming scenario.
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    // The client endpoint configuration.
    HelloWorldClient ep = check new("http://localhost:9090");
    // Execute the streaming RPC call that registers
    // the server message listener and gets the response as a stream.
    stream<anydata, grpc:Error?> result = check ep->lotsOfReplies("WSO2");
    // Iterate through the stream and print the content.
    error? e = result.forEach(function(anydata str) {
        io:println(str);
    });
}

// The client, which is used to invoke the RPC.
public client class HelloWorldClient {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public isolated function init(string url,
    grpc:ClientConfiguration? config = ()) returns grpc:Error? {
        // Initialize the client endpoint.
        self.grpcClient = check new(url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR,
        getDescriptorMap());
    }

    isolated remote function lotsOfReplies(string req)
                              returns stream<string, grpc:Error?>|grpc:Error {

        var payload = check self.grpcClient->executeServerStreaming(
        "HelloWorld/lotsOfReplies", req);
        [stream<anydata, grpc:Error?>, map<string|string[]>][result, _] =
        payload;
        StringStream outputStream = new StringStream(result);
        return new stream<string, grpc:Error?>(outputStream);
    }

    isolated remote function lotsOfRepliesContext(string req)
                             returns ContextStringStream|grpc:Error {

        var payload = check self.grpcClient->executeServerStreaming(
        "HelloWorld/lotsOfReplies", req);
        [stream<anydata, grpc:Error?>, map<string|string[]>][result, headers] =
        payload;
        StringStream outputStream = new StringStream(result);
        return {content: new stream<string, grpc:Error?>(outputStream),
         headers: headers};
    }

}

public class StringStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns
                            record {| string value; |}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {| string value; |} nextRecord =
            {value: <string>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextStringStream record {|
    stream<string> content;
    map<string|string[]> headers;
|};
