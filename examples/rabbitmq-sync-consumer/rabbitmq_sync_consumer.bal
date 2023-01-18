import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Consuming message from the routing key OrderQueue.
    Order 'order = check newClient->consumePayload("OrderQueue");
    if 'order.isValid {
        log:printInfo(string `Received valid order for ${'order.productName}`);
    }
}
