import ballerina/constraint;
import ballerinax/kafka;
import ballerina/io;

public type Order record {
    int orderId;
    // Add a constraint to only allow string values of length between 30 and 1.
    @constraint:String {maxLength: 30, minLength: 1}
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
        do {
            Order[] orders = check orderConsumer->pollPayload(15);
            check from Order 'order in orders
                where 'order.isValid
                do {
                    io:println(string `Received valid order for ${'order.productName}`);
                };
        } on fail error orderError {
            // Check whether the `error` is a `kafka:PayloadValidationError` and seek pass the
            // erroneous record.
            if orderError is kafka:PayloadValidationError {
                io:println("Payload validation failed", orderError);
                // The `kafka:PartitionOffset` related to the erroneous record is provided inside
                // the `kafka:PayloadValidationError`.
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
