import ballerinax/kafka;
import ballerina/lang.'string;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    // The `bootstrapServers` is the list of remote server endpoints of the
    // Kafka brokers.
    bootstrapServers: "localhost:9092",
    // Using two concurrent consumers to work as a group.
    concurrentConsumers: 2,

    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingIntervalInMillis: 1000,
    // Uses the default string deserializer to deserialize the Kafka value.
    valueDeserializerType: kafka:DES_BYTE_ARRAY

};

listener kafka:Listener kafkaListener = new (consumerConfigs);

service kafka:Service on kafkaListener {
    // This remote function executes when a message or a set of messages are published
    // to the subscribed topic/topics.
    remote function onMessage(kafka:Caller caller,
                        kafka:ConsumerRecord[] records) {
        // The set of Kafka records dispatched to the service are processed one
        // by one.
        foreach var kafkaRecord in records {
            processKafkaRecord(kafkaRecord);
        }

    }
}

function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) {
    byte[] messageContent = kafkaRecord.value;
    string|error message = 'string:fromBytes(messageContent);
    if (message is string) {
        // Prints the retrieved message.
        log:printInfo(" Received Message: " + message);

    } else {
        log:printError("Error occurred while retrieving message data;" +
            "Unexpected type");
    }
}
