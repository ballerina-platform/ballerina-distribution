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
        do {
            // Polls the consumer for order records.
            OrderConsumerRecord[] records = check orderConsumer->poll(15);
            check from OrderConsumerRecord orderRecord in records
                where orderRecord.value.isValid
                do {
                    io:println(string `Received valid order for ${orderRecord.value.productName}`);
                };
        } on fail error orderError {
            // Check whether the `error` is a `kafka:PayloadBindingError` and seek pass the
            // erroneous record.
            if orderError is kafka:PayloadBindingError {
                io:println("Payload binding failed", orderError);
                // The `kafka:PartitionOffset` related to the erroneous record is provided inside
                // the `kafka:PayloadBindingError`.
                check orderConsumer->seek({
                    partition: orderError.detail().partition,
                    offset: orderError.detail().offset + 1
                });
            } else {
                check orderConsumer->close();
                return orderError;
            }
        }
    }
}
