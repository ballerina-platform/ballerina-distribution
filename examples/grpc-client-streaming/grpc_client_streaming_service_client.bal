// This is the client implementation for the client streaming scenario.
import ballerina/io;

// The client endpoint configuration.
HelloWorldClient ep = check new("http://localhost:9090");

public function main () returns error? {
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];
    // Execute the client-streaming RPC call and receive the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check
    ep->lotsOfGreetings();
    // Send multiple messages to the server.
    foreach var greet in requests {
        check streamingClient->sendstring(greet);
    }
    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    check streamingClient->complete();
    io:println("Completed successfully");
    string? response = check streamingClient->receiveString();
    io:println(response);

}
