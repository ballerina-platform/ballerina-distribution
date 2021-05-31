import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    // Uses two concurrent consumers to work as a group.
    concurrentConsumers: 2,

    groupId: "group-id",
    // Subscribes to the `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingInterval: 1
};

listener kafka:Listener kafkaListener =
            new (kafka:DEFAULT_URL, consumerConfigs);

service kafka:Service on kafkaListener {
    // This remote function executes when a message or a set of messages are published
    // to the subscribed topic/topics.
    remote function onConsumerRecord(kafka:Caller caller,
                        kafka:ConsumerRecord[] records) returns error? {
        // The set of Kafka records received by the service are processed one
        // by one.
        foreach var kafkaRecord in records {
            check processKafkaRecord(kafkaRecord);
        }

    }
}

function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) returns error? {
    byte[] messageContent = kafkaRecord.value;
    // Converts the `byte[]` to a `string`.
    string message = check string:fromBytes(messageContent);

    // Prints the retrieved message.
    log:printInfo("Received Message: " + message);
}
