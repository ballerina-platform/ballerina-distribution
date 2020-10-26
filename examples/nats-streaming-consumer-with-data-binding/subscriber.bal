import ballerina/io;
import ballerinax/nats;

// Creates a NATS connection.
nats:Connection conn = new;

// Initializes the NATS Streaming listener.
listener nats:StreamingListener lis = new (conn);

// Binds the consumer to listen to the messages published to the 'demo' subject.
@nats:StreamingSubscriptionConfig {
    subject: "demo"
}
service demoService on lis {
    resource function onMessage(nats:StreamingMessage message, json data) {
        // Converts JSON data to string.
        string|error val = data.toJsonString();
        if (val is string) {
            // Prints the incoming message in the console.
            io:println("Received message: " + val);
        } else {
            io:println("Error occurred during json to string conversion.");
        }
    }

    resource function onError(nats:StreamingMessage message,
                              nats:Error errorVal) {
        io:println("Error occurred while consuming the message.");
    }
}
