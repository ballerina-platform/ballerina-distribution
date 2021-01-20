import ballerina/io;
import ballerinax/kafka;
import ballerina/lang.'string;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfiguration = {
    // The `bootstrapServers` is the list of remote server endpoints of the
    // Kafka brokers.
    bootstrapServers: "localhost:9092",

    groupId: "group-id",
    offsetReset: "earliest",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"]

};

kafka:Consumer consumer = checkpanic new (consumerConfiguration);

public function main() returns error? {
    // Poll the consumer for messages.
    kafka:ConsumerRecord[] records = check consumer->poll(1000);

    foreach var kafkaRecord in records {
        byte[] messageContent = kafkaRecord.value;
        string|error message = 'string:fromBytes(messageContent);

        if (message is string) {
            // Prints the retrieved Kafka record.
            io:println("Received Message: ", message);

        } else {
            log:printError("Error occurred while converting message data",
                err = message);
        }
    }
}
