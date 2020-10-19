import ballerina/io;
import ballerinax/nats;

// Produces a message to a subject in the NATS sever.
public function main() returns error? {
    string message = "Hello from Ballerina";
    // Initializes a producer.
    nats:Connection connection = new ();
    nats:Producer producer = new (connection);
    // Produces a message to the specified subject.
    nats:Error? result = producer->publish("demo.bbe.subject", <@untainted>message);
    if (result is nats:Error) {
        io:println("Error occurred while producing the message.");
    } else {
        io:println("Message published successfully.");
    }

    // Closes the publisher connection.
    check producer.close();
    check connection.close();
}
