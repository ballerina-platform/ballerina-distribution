import ballerinax/rabbitmq;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns error? {
    // Creates a ballerina RabbitMQ client with TLS/SSL.
    rabbitmq:Client rabbitmqClient = check new(rabbitmq:DEFAULT_HOST, 5671,

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    // Publishes the message using newClient and the routing key named OrderQueue.
    check rabbitmqClient->publishMessage({
        content: {
            orderId: 1,
            productName: "Sport shoe",
            price: 27.5,
            isValid: true
        },
        routingKey: "OrderQueue"
    });
}
