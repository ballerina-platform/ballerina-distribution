import ballerina/io;
import ballerinax/nats;

// Initializes a connection.
nats:Connection connection = new;

// Initializes the NATS listener.
listener nats:Listener subscription = new (connection);

// Binds the consumer to listen to the messages published to the 'demo' subject.
@nats:SubscriptionConfig {
    subject: "demo.bbe.*"
}
service demo on subscription {

    resource function onMessage(nats:Message msg, string data) {
        // Prints the incoming message in the console.
        io:println("Received message: " + data);
    }

    resource function onError(nats:Message msg, nats:Error err) {
        io:println("Error occurred while consuming the message.");
    }
}
