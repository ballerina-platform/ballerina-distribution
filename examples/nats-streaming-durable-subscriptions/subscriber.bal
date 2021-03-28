import ballerina/io;
import ballerinax/stan;

// Initializes the NATS Streaming listener.
listener stan:Listener lis = new(stan:DEFAULT_URL, clientId = "c0");

// Binds the consumer to listen to the messages published to the 'demo' subject.
@stan:ServiceConfig {
    subject: "demo",
    durableName: "sample-name"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = string:fromBytes(message.content);
       if (messageData is string) {
            io:println("Received message: " + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}
