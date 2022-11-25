import ballerinax/kafka;
import ballerina/io;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
        groupId: "order-group-id",
        topics: "order-topic"
    });

    // Polls the consumer for payload.
    Order[] orders = check orderConsumer->pollPayload(1);

    check from Order 'order in orders
        where 'order.isValid
        do {
            io:println(string `Received valid order for ${'order.productName}`);
        };
}
