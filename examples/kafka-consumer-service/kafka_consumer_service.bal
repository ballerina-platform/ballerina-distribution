import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingInterval: 1
};

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

// Create a subtype of `kafka:AnydataConsumerRecord`
public type OrderConsumerRecord record {|
    *kafka:AnydataConsumerRecord;
    Order value;
|};

service on new kafka:Listener(kafka:DEFAULT_URL, consumerConfigs) {
    remote function onConsumerRecord(OrderConsumerRecord[] records)
                                                        returns error? {
        // The set of Kafka records received by the service are processed one by one.
        check from OrderConsumerRecord orderRecord in records
            where orderRecord.value.isValid
            do {
                log:printInfo("Received Valid Order: " +
                                    orderRecord.value.toString());
            };
    }
}
