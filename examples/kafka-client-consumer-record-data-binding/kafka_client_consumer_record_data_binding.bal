import ballerinax/kafka;
import ballerina/io;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

// Create a subtype of `kafka:AnydataConsumerRecord`.
public type OrderConsumerRecord record {|
    *kafka:AnydataConsumerRecord;
    Order value;
|};

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "order-group-id",
    topics: "order-topic"
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

    // Polls the consumer for order records.
    OrderConsumerRecord[] records = check orderConsumer->poll(1);

    check from OrderConsumerRecord orderRecord in records
        where orderRecord.value.isValid
        do {
            io:println(orderRecord.value.productName);
        };
}
