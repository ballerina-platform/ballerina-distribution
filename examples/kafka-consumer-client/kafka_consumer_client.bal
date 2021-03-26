import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "group-id",
    offsetReset: "earliest",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"]

};

kafka:Consumer consumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

public function main() returns error? {
    // Poll the consumer for messages.
    kafka:ConsumerRecord[] records = check consumer->poll(1);

    foreach var kafkaRecord in records {
        byte[] messageContent = kafkaRecord.value;
        string|error message = string:fromBytes(messageContent);

        if (message is string) {
            // Prints the retrieved Kafka record.
            log:printInfo("Received Message: ", message);

        } else {
            log:printError("Error occurred while converting message data",
                err = message);
        }
    }
}
