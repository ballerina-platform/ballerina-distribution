// This is the client implementation for the client streaming scenario.
import ballerina/io;

// Create a gRPC client to interact with the remote server.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    // Execute the client-streaming RPC call and receive the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check
    ep->lotsOfGreetings();

    // Send multiple messages to the server.
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];
    foreach var greet in requests {
        check streamingClient->sendString(greet);
    }

    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    check streamingClient->complete();

    // Receive server response
    string? response = check streamingClient->receiveString();
    io:println(response);

}
