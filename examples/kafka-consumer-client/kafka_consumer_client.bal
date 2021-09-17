import ballerinax/kafka;
import ballerina/io;

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "group-id",
    offsetReset: "earliest",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"]

};

kafka:Consumer consumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

public function main() returns error? {
    // Polls the consumer for messages.
    kafka:ConsumerRecord[] records = check consumer->poll(1);

    foreach var kafkaRecord in records {
        byte[] messageContent = kafkaRecord.value;
        // Converts the `byte[]` to a `string`.
        string message = check string:fromBytes(messageContent);

        // Prints the retrieved Kafka record.
        io:println("Received Message: " + message);
    }
}
