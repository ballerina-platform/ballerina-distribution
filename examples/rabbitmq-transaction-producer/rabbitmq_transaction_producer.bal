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
        self.orderClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);
    }

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        transaction {
            // Publishes the message using newClient and the routing key named OrderQueue.
            check self.orderClient->publishMessage({
                content: newOrder,
                routingKey: "OrderQueue"
            });
            check commit;
        }
        return http:ACCEPTED;
    }
}
