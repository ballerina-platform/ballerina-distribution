import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Publishing messages to an exchange using a routing key.
    // Publishes the message using newClient and the routing key named MyQueue.
    check newClient->publishMessage({content: "Hello from Ballerina", routingKey: "MyQueue"});
}
