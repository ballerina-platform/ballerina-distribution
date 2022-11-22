import ballerinax/kafka;
import ballerina/log;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "order-group-id",
    topics: ["order-topic"]
};

service on new kafka:Listener(kafka:DEFAULT_URL, consumerConfigs) {
    remote function onConsumerRecord(Order[] orders) returns error? {
        // The set of orders received by the service are processed one by one.
        check from Order 'order in orders
            where 'order.isValid
            do {
                log:printInfo("Received Valid Order: " + 'order.toString());
            };
    }
}
