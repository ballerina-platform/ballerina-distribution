import ballerinax/kafka;
import ballerina/io;

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "group-id",
    offsetReset: "earliest",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"]

};

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

kafka:Consumer consumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

public function main() returns error? {
    // Polls the consumer for payload.
    Order[] orderData = check consumer->pollPayload(1);

    check from Order 'order in orderData
        where 'order.isValid
        do {
            io:println('order.productName);
        };
}
