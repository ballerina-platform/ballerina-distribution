import ballerinax/kafka;
import ballerina/io;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
        groupId: "order-group-id",
        topics: "order-topic"
    });

    while true {
        // Polls the consumer for payload.
        Order[] orders = check orderConsumer->pollPayload(15);
        check from Order 'order in orders
            where 'order.isValid
            do {
                io:println(string `Received valid order for ${'order.productName}`);
            };
    }
}
