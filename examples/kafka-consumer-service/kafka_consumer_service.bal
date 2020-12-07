import ballerinax/kafka;
import ballerina/lang.'string;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    // The `bootstrapServers` is the list of remote server endpoints of the
    // Kafka brokers.
    bootstrapServers: "localhost:9092",

    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingIntervalInMillis: 1000,
    // Uses the default int deserializer for the keys.
    keyDeserializerType: kafka:DES_BYTE_ARRAY,
    // Uses the default string deserializer for the values.
    valueDeserializerType: kafka:DES_BYTE_ARRAY,
    // Set `autoCommit` to false, so that the records should be committed
    // manually.
    autoCommit: false
};

listener kafka:Listener kafkaListener = new (consumerConfigs);

service kafka:Service on kafkaListener {
    remote function onMessage(kafka:Caller caller,
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
                "offsets for the consumer ", commitResult);
        }
    }
}

function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) {
    byte[] value = kafkaRecord.value;
    // The value should be a `byte[]`, since the byte[] deserializer is used
    // for the value.
    string|error messageContent = 'string:fromBytes(value);
    if (messageContent is string) {
            log:printInfo("Value: " + messageContent);
    } else {
        log:printError("Invalid value type received");
    }
}
