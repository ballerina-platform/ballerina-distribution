import ballerina/log;
import ballerinax/stan;

// Initializes the NATS Streaming listener.
listener stan:Listener lis = new(stan:DEFAULT_URL);

// Binds the consumer to listen to the messages published to the 'demo' subject.
@stan:ServiceConfig {
    subject: "demo"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Received message: " + messageData);
        }
    }
}
