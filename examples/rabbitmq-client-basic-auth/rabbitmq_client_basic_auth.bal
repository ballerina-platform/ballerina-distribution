import ballerinax/rabbitmq;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

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
