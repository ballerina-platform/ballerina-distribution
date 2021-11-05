import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ Client.
    rabbitmq:Client newClient =
            check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Declares the queue.
    check newClient->queueDeclare("MyQueue");
    transaction {
        string message = "Hello from Ballerina";
        // Publishes the message using the routing key named "MyQueue".
        check newClient->publishMessage({ content: message.toBytes(),
                                                    routingKey: "MyQueue" });
        check commit;
    }
}
