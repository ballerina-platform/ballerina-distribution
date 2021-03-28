import ballerina/io;
import ballerinax/stan;

// Initializes the NATS Streaming listeners.
listener stan:Listener lis = new(stan:DEFAULT_URL);

// Binds the consumer to listen to the messages published to the 'demo' subject.
// Belongs to the queue group named "sample-queue-group"
@stan:ServiceConfig {
    subject: "demo",
    queueGroup: "sample-queue-group"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = string:fromBytes(message.content);
       if (messageData is string) {
            io:println("Message Received to first queue group member: "
                                                        + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}

// Belongs to the queue group named "sample-queue-group"
@stan:ServiceConfig {
    subject: "demo",
    queueGroup: "sample-queue-group"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = string:fromBytes(message.content);
       if (messageData is string) {
            io:println("Message Received to second queue group member: "
                                                        + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}

// Belongs to the queue group named "sample-queue-group"
@stan:ServiceConfig {
    subject: "demo",
    queueGroup: "sample-queue-group"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = string:fromBytes(message.content);
       if (messageData is string) {
            io:println("Message Received to third queue group member: "
                                                        + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}
