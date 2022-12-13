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
        Order[]|kafka:Error orders = orderConsumer->pollPayload(15);
        if orders is Order[] {
            check from Order 'order in orders
                where 'order.isValid
                do {
                    io:println(string `Received valid order for ${'order.productName}`);
                };
            // Check whether the `error` is a `kafka:PayloadValidationError` and seek pass the
            // erroneous record.
        } else if orders is kafka:PayloadValidationError {
            io:println("Payload validation failed", orders);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadValidationError`.
            check orderConsumer->seek({
                partition: orders.detail().partition,
                offset: orders.detail().offset + 1
            });
        } else {
            check orderConsumer->close();
            return orders;
        }
    }
}
