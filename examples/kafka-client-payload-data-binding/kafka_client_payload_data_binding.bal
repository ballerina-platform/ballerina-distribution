import ballerinax/kafka;
import ballerina/io;

public type Order readonly & record {
    int orderId;
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
        // Polls the consumer for payload.
        Order[]|kafka:Error orders = orderConsumer->pollPayload(15);
        if orders is Order[] {
            check from Order 'order in orders
                where 'order.isValid
                do {
                    io:println(string `Received valid order for ${'order.productName}`);
                };
            // Check whether the `error` is a `kafka:PayloadBindingError` and seek pass the
            // erroneous record.
        } else if orders is kafka:PayloadBindingError {
            io:println("Payload binding failed", orders);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadBindingError`.
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
