import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client with TLS/SSL.
    rabbitmq:Client rabbitmqClient = check new(rabbitmq:DEFAULT_HOST, 5671,

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    check rabbitmqClient->queueDeclare("Secured");

    // Publishes the message using the `rabbitmqClient` and the routing key named `Secured`.
    string message = "Hello from Ballerina";
    check rabbitmqClient->publishMessage({content: message, routingKey: "Secured"});
}
