import ballerina/io;
import ballerinax/rabbitmq;

public function main() {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = new;

    // Declares the queue, MyQueue.
    var queueResult1 = newClient->queueDeclare("MyQueue");
    if (queueResult1 is error) {
        io:println("An error occurred while creating the MyQueue1 queue.");
    }

    // Publishing messages to an exchange using a routing key.
    // Publishes the message using newChannel1 and the routing key named MyQueue.
    string message = "Hello from Ballerina";
    var sendResult = newClient->basicPublish(message.toBytes(),
                                    "MyQueue");
    if (sendResult is error) {
        io:println("An error occurred while sending the message to " +
                 "MyQueue1 using newChannel1.");
    }
}
