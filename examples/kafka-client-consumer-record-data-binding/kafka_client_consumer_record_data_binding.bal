import ballerinax/kafka;
import ballerina/io;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Create a subtype of `kafka:AnydataConsumerRecord`.
public type OrderConsumerRecord record {|
    *kafka:AnydataConsumerRecord;
    Order value;
|};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
        groupId: "order-group-id",
        topics: "order-topic"
    });

    // Polls the consumer for order records.
    OrderConsumerRecord[] records = check orderConsumer->poll(1);

    check from OrderConsumerRecord orderRecord in records
        where orderRecord.value.isValid
        do {
            io:println(string `Received valid order for ${orderRecord.value.productName}`);
        };
}
