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

// Create a subtype of `kafka:AnydataConsumerRecord`
public type OrderConsumerRecord record {|
    *kafka:AnydataConsumerRecord;
    Order value;
|};

kafka:Consumer orderConsumer =
                check new (kafka:DEFAULT_URL, consumerConfiguration);

public function main() returns error? {
    // Polls the consumer for order records.
    OrderConsumerRecord[] records = check orderConsumer->poll(1);

    check from OrderConsumerRecord orderRecord in records
        where orderRecord.value.isValid
        do {
            io:println(orderRecord.value.productName);
        };
}
