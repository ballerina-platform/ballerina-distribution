import ballerina/log;
import ballerinax/stan;

// Initializes the NATS Streaming listener with a specific client ID.
listener stan:Listener lis = new (stan:DEFAULT_URL, clientId = "c0");

// Provides the durable name to create a durable subscription.
@stan:ServiceConfig {
    subject: "demo",
    durableName: "sample-name"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) returns error? {
        // Prints the incoming message in the console.
        string messageData = check string:fromBytes(message.content);
        log:printInfo("Received message: " + messageData);
    }
}
