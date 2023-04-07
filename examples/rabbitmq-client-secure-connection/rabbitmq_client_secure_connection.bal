import ballerina/http;
import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9092) {
    private final rabbitmq:Client orderClient;

    function init() returns error? {
        // Initiate the RabbitMQ client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.orderClient = check new (rabbitmq:DEFAULT_HOST, 5671,
            // To secure the client connection using TLS/SSL, the client needs to be configured with
            // a certificate file of the server.
            secureSocket = {
                cert: "../resource/path/to/public.crt"
            }
        );
    }

    resource function post orders(Order newOrder) returns http:Accepted|error {
        // Publishes the message using the `newClient` and the routing key named `OrderQueue`.
        check self.orderClient->publishMessage({
            content: newOrder,
            routingKey: "OrderQueue"
        });

        return http:ACCEPTED;
    }
}
