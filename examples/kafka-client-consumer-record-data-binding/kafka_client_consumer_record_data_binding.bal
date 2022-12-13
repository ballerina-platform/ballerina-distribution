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

    while true {
        // Polls the consumer for order records.
        OrderConsumerRecord[]|kafka:Error records = orderConsumer->poll(15);
        if records is OrderConsumerRecord[] {
            check from OrderConsumerRecord orderRecord in records
                where orderRecord.value.isValid
                do {
                    io:println(string `Received valid order for ${orderRecord.value.productName}`);
                };
            // Check whether the `error` is a `kafka:PayloadBindingError` and seek pass the
            // erroneous record.
        } else if records is kafka:PayloadBindingError {
            io:println("Payload binding failed", records);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadBindingError`.
            check orderConsumer->seek({
                partition: records.detail().partition,
                offset: records.detail().offset + 1
            });
        } else {
            check orderConsumer->close();
            return records;
        }
    }
}
