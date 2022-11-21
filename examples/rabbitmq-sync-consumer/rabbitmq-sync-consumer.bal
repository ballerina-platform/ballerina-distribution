import ballerina/log;
import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Consuming message from the routing key MyQueue.
    string messageReceived = check newClient->consumePayload("MyQueue");
    log:printInfo("Received message: " + messageReceived);
}
