import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client with TLS/SSL and username/password authentication.
    rabbitmq:Client rabbitmqClient = check new(rabbitmq:DEFAULT_HOST, 5671,

        // To secure the client connections using username/password authentication, provide the credentials
        // with the [`rabbitmq:Credentials`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials) record.
        auth = {
             username: "alice",
             password: "alice@123"
        },

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        // The [`rabbitmq:SecureSocket`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
        // record provides the SSL-related configurations of the client.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    // Declares the queue, Secured.
    check rabbitmqClient->queueDeclare("Secured");

    // Publishes the message using the `rabbitmqClient` and the routing key named `Secured`.
    string message = "Hello from Ballerina";
    check rabbitmqClient->publishMessage({ content: message.toBytes(),
                                            routingKey: "Secured" });
}
