import ballerinax/kafka;
import ballerina/io;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "group-id",
    offsetReset: "earliest",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"]
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

    // Polls the consumer for payload.
    Order[] orders = check orderConsumer->pollPayload(1);

    check from Order 'order in orders
        where 'order.isValid
        do {
            io:println('order.productName);
        };
}
