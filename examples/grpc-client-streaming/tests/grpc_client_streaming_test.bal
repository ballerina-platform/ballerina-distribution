// This is the Ballerina test for the client streaming scenario.
import ballerina/test;

// Client endpoint configuration.
HelloWorldClient helloWorldEp = check new("http://localhost:9090");

@test:Config
function testClientStreamingService() returns error? {
    // Execute the client-streaming RPC call and receive the streaming client.
    LotsOfGreetingsStreamingClient streamingClient = check ep->lotsOfGreetings();
    string[] requests = ["Hi Sam", "Hey Sam", "GM Sam"];

    // Send multiple messages to the server.
    string[] greets = ["Hi", "Hey", "GM"];
    foreach var greet in requests {
        check streamingClient->sendString(greet);
    }

    // Once all the messages are sent, the server notifies the caller with a `complete` message.
    check streamingClient->complete();

    string? response = check streamingClient->receiveString();
    string expected = "Ack";
    test:assertEquals(response is () ? "" : response, expected);
}
