// This is the client implementation for the client streaming scenario.
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
