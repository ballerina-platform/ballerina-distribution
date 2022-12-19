import ballerinax/kafka;
import ballerina/log;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

listener kafka:Listener orderListener = check new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: "order-topic"
});

service on orderListener {

    remote function onConsumerRecord(Order[] orders) returns error? {
        // The set of orders received by the service are processed one by one.
        check from Order 'order in orders
            where 'order.isValid
            do {
                log:printInfo(string `Received valid order for ${'order.productName}`);
            };
    }

    // When an error occurs before the `onConsumerRecord` gets invoked,
    // `onError` function will get invoked.
    remote function onError(kafka:Error 'error, kafka:Caller caller) returns error? {
        // Check whether the `error` is a `kafka:PayloadBindingError` and seek pass the
        // erroneous record.
        if 'error is kafka:PayloadBindingError {
            log:printError("Payload binding failed", 'error);
            // The `kafka:PartitionOffset` related to the erroneous record is provided inside
            // the `kafka:PayloadBindingError`.
            check caller->seek({
                partition: 'error.detail().partition,
                offset: 'error.detail().offset + 1
            });
        } else {
            log:printError("An error occured", 'error);
        }
    }
}
