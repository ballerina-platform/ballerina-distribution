import ballerina/constraint;
import ballerinax/kafka;
import ballerina/lang.runtime;
import ballerina/log;

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
        topics: ["order-topic"]
    });
    while true {
        Order[]|kafka:Error response = orderConsumer->pollPayload(1);
        if response is Order[] {
            check from Order 'order in response
                do {
                    log:printInfo(string `Received valid order for ${'order.productName}`);
                };
        // Check whether the `error` is a `kafka:PayloadValidationError` and seek past the
        // erroneous record.
        } else if response is kafka:PayloadValidationError {
            log:printError("Payload validation failed", response);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadValidationError`.
            check orderConsumer->seek({
                partition: response.detail().partition,
                offset: response.detail().offset + 1
            });
        } else {
            log:printError("An error occured", response);
            break;
        }
        runtime:sleep(1);
    }
}
