// This is the client implementation of the client streaming scenario.
import ballerina/io;

// Creates a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Executes the client-streaming RPC call and receives the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check
    ep->lotsOfGreetings();

    // Sends multiple messages to the server.
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];
    foreach var greet in requests {
        check streamingClient->sendString(greet);
    }

    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    check streamingClient->complete();

    // Receives the server response.
    string? response = check streamingClient->receiveString();
    io:println(response);

}
