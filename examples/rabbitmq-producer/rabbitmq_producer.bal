import ballerina/http;
import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a ballerina RabbitMQ client.
final rabbitmq:Client orderClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

service / on new http:Listener(9092) {

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        // Publishes the message using newClient and the routing key named OrderQueue.
        check orderClient->publishMessage({
            content: newOrder,
            routingKey: "OrderQueue"
        });

        return http:ACCEPTED;
    }
}
