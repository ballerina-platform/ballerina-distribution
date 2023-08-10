import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Declares the queue, OrderQueue.
    check newClient->queueDeclare("OrderQueue");
}
