import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client with username/password authentication.
    rabbitmq:Client rabbitmqClient = check new(rabbitmq:DEFAULT_HOST, 5672,
        // To secure the client connections using username/password authentication, provide the credentials
        // with the `rabbitmq:Credentials` record.
        auth = {
             username: "alice",
             password: "alice@123"
        }
    );

    check rabbitmqClient->queueDeclare("Secured");

    // Publishes the message using the `rabbitmqClient` and the routing key named `Secured`.
    string message = "Hello from Ballerina";
    check rabbitmqClient->publishMessage({content: message.toBytes(), routingKey: "Secured"});
}
