// This is the client implementation for the client streaming scenario.
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    // The client endpoint configuration.
    HelloWorldClient ep = check new("http://localhost:9090");
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];
    // Execute the client-streaming RPC call and receive the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check
    ep->lotsOfGreetings();
    // Send multiple messages to the server.
    foreach var greet in requests {
        checkpanic streamingClient->sendstring(greet);
    }
    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    checkpanic streamingClient->complete();
    io:println("Completed successfully");
    anydata response = checkpanic streamingClient->receiveString();
    io:println(response);

}

// The client that used to invoke the RPC.
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

    isolated remote function lotsOfGreetings()
                    returns (LotsOfGreetingsStreamingClient|grpc:Error) {
        grpc:StreamingClient sClient = check
        self.grpcClient->executeClientStreaming("HelloWorld/lotsOfGreetings");
        return new LotsOfGreetingsStreamingClient(sClient);
    }
}

// The streaming client, which is used to send the streaming messages.
public client class LotsOfGreetingsStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendstring(string message) returns grpc:Error? {

        return self.sClient->send(message);
    }

    isolated remote function sendContextString(ContextString message) returns
    grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error {
        [anydata, map<string|string[]>] [payload, headers] =
        check self.sClient->receive();
        return payload.toString();
    }

    isolated remote function receiveContextString() returns
    ContextString|grpc:Error {
        [anydata, map<string|string[]>] [payload, headers] =
        check self.sClient->receive();
        return {content: payload.toString(), headers: headers};
    }

    isolated remote function sendError(grpc:Error response) returns
    grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

// The context record includes the message payload and headers.
public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};
