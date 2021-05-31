import ballerina/log;
import ballerinax/stan;

// Initializes the NATS Streaming listener with a specific client ID.
listener stan:Listener lis = new(stan:DEFAULT_URL, clientId = "c0");

// Provides the durable name to create a durable subscription.
@stan:ServiceConfig {
    subject: "demo",
    durableName: "sample-name"
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
