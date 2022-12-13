import ballerina/constraint;
import ballerina/http;
import ballerinax/kafka;
import ballerina/log;

public type Order record {
    int orderId;
    // Add a constraint to only allow string values of length between 30 and 1.
    @constraint:String {maxLength: 30, minLength: 1}
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: "order-topic"
});

service / on new http:Listener(9090) {
    resource function get orders() returns Order[]|kafka:Error {
        while true {
            Order[]|kafka:Error orders = orderConsumer->pollPayload(15);
            if orders is Order[] {
                return from Order 'order in orders
                    where 'order.isValid
                    select 'order;
                // Check whether the `error` is a `kafka:PayloadValidationError` and seek pass the
                // erroneous record.
            } else if orders is kafka:PayloadValidationError {
                log:printError("Payload validation failed", orders);
                // The `kafka:PartitionOffset` related to the erroneous record is provided inside
                // the `kafka:PayloadValidationError`.
                check orderConsumer->seek({
                    partition: orders.detail().partition,
                    offset: orders.detail().offset + 1
                });
            } else {
                return orders;
            }
        }
    }
}
