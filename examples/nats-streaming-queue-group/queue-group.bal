import ballerina/lang.'string as strings;
import ballerina/io;
import ballerinax/stan;

// Initializes the NATS Streaming listeners.
listener stan:Listener lis = new;

// Binds the consumer to listen to the messages published to the 'demo' subject.
// Belongs to the queue group named "sample-queue-group"
@stan:ServiceConfig {
    subject: "demo",
    queueName: "sample-queue-group"
}
service stan:StanService on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = strings:fromBytes(message.content);
       if (messageData is string) {
            io:println("Message Received to first queue group member: "
                                                        + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}
