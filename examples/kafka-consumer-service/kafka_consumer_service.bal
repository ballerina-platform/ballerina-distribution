import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingInterval: 1,

    // Set `autoCommit` to false, so that the records should be committed
    // manually.
    autoCommit: false
};

listener kafka:Listener kafkaListener =
        new (kafka:DEFAULT_URL, consumerConfigs);

service kafka:Service on kafkaListener {
    remote function onConsumerRecord(kafka:Caller caller,
                                kafka:ConsumerRecord[] records) {
        // The set of Kafka records dispatched to the service are processed one
        // by one.
        foreach var kafkaRecord in records {
            processKafkaRecord(kafkaRecord);
        }
        // Commit offsets for returned records by marking them as consumed.
        var commitResult = caller->commit();

        if (commitResult is error) {
            log:printError("Error occurred while committing the " +
                "offsets for the consumer ", err = commitResult);
        }
    }
}

function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) {
    byte[] value = kafkaRecord.value;
    // The value should be a `byte[]`, since the byte[] deserializer is used
    // for the value.
    string|error messageContent = string:fromBytes(value);
    if (messageContent is string) {
        log:print("Value: " + messageContent);
    } else {
        log:printError("Invalid value type received");
    }
}
