import ballerina/constraint;
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

listener kafka:Listener orderListener = check new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: ["order-topic"]
});

service on orderListener {
    remote function onConsumerRecord(Order[] orders) returns error? {
        check from Order 'order in orders
            do {
                log:printInfo(string `Received valid order for ${'order.productName}`);
            };
    }

    // When an error occurs in the before the `onConsumerRecord` invoke,
    // `onError` function will get invoked.
    remote function onError(kafka:Error 'error, kafka:Caller caller) returns error? {
        // Check whether the `error` is a `kafka:PayloadValidationError` and seek past the
        // erroneous record.
        if 'error is kafka:PayloadValidationError {
            log:printError("Payload validation failed", 'error);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadValidationError`.
            check caller->seek({
                partition: 'error.detail().partition,
                offset: 'error.detail().offset + 1
            });
        } else {
            log:printError("An error occured", 'error);
        }
    }
}
