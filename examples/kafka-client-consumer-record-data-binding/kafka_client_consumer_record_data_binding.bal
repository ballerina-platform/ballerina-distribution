import ballerinax/kafka;
import ballerina/http;

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

final kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: "order-topic"
});

service / on new http:Listener(9090) {
    resource function get orders() returns Order[]|kafka:Error {
        // Polls the consumer for order records.
        OrderConsumerRecord[] records = check orderConsumer->poll(1);

        return from OrderConsumerRecord orderRecord in records
            where orderRecord.value.isValid
            select orderRecord.value;
    }
}
