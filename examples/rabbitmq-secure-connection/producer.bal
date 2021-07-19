import ballerinax/rabbitmq;

public function main() returns error? {
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    // The [`rabbitmq:SecureSocket`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
    // record provides th   e SSL-related configurations of the client.
    rabbitmq:SecureSocket sslConfig = { cert: "../resource/path/to/public.crt" };

    // To secure the client connections using basic authentication, provide the credentials
    // with the [`rabbitmq:Credentials`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials) record.
    rabbitmq:Credentials credentials = { username: "ballerina",
                                         password: "ballerina@123" };

    // Creates a ballerina RabbitMQ client with TLS/SSL and basic authentication.
    rabbitmq:Client newClient =
                check new(rabbitmq:DEFAULT_HOST, 5671,
                auth = credentials, secureSocket = sslConfig);

    // Declares the queue, Secured.
    check newClient->queueDeclare("Secured");

    // Publishes the message using newClient and the routing key named MyQueue.
    string message = "Hello from Ballerina";
    check newClient->publishMessage({ content: message.toBytes(),
                                            routingKey: "Secured" });
}
