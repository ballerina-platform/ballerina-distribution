import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient =
                check new(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Declares the queue, MyQueue.
    check newClient->queueDeclare("MyQueue");

    // Publishing messages to an exchange using a routing key.
    // Publishes the message using newClient and the routing key named MyQueue.
    string message = "Hello from Ballerina";
    check newClient->publishMessage({ content: message.toBytes(),
                                            routingKey: "MyQueue" });
}
