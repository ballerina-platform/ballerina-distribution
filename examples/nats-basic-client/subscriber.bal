import ballerina/io;
import ballerinax/nats;

// Initializes the NATS listener.
listener nats:Listener subscription = new(nats:DEFAULT_URL);

// Binds the consumer to listen to the messages published to the 'demo' subject.
@nats:ServiceConfig {
    subject: "demo.bbe.*"
}
service nats:Service on subscription {

    remote function onMessage(nats:Message message) {
        // Prints the incoming message in the console.
        string|error messageContent = string:fromBytes(message.content);
        if (messageContent is string) {
            io:println("Received message: " + messageContent);
        }
    }
}
