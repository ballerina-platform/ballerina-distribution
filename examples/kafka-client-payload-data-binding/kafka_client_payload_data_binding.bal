import ballerinax/kafka;
import ballerina/http;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: "order-topic"
});

service / on new http:Listener(9090) {
    resource function get orders() returns Order[]|kafka:Error {
        // Polls the consumer for payload.
        Order[] orders = check orderConsumer->pollPayload(1);

        return from Order 'order in orders
            where 'order.isValid
            select 'order;
    }
}
