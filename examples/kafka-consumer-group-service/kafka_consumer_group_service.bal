import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    // Using two concurrent consumers to work as a group.
    concurrentConsumers: 2,

    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],

    pollingInterval: 1

};

listener kafka:Listener kafkaListener =
            new (kafka:DEFAULT_URL, consumerConfigs);

service kafka:Service on kafkaListener {
    // This remote function executes when a message or a set of messages are published
    // to the subscribed topic/topics.
    remote function onConsumerRecord(kafka:Caller caller,
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
    string|error message = string:fromBytes(messageContent);
    if (message is string) {
        // Prints the retrieved message.
        log:print(" Received Message: " + message);

    } else {
        log:printError("Error occurred while retrieving message data;" +
            "Unexpected type");
    }
}
