import ballerina/lang.'string as strings;
import ballerina/io;
import ballerinax/stan;

// Initializes the NATS Streaming listener.
listener stan:Listener lis = checkpanic new;

// Binds the consumer to listen to the messages published to the 'demo' subject.
// By default, only new messages are received.
@stan:ServiceConfig {
    subject: "demo"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
       // Prints the incoming message in the console.
       string|error messageData = strings:fromBytes(message.content);
       if (messageData is string) {
            io:println("Message received to service receiveNewOnly: "
                                                      + messageData);
       } else {
            io:println("Error occurred while obtaining message data.");
       }
    }
}
