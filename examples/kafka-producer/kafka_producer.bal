import ballerinax/kafka;

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL);

public function main() returns error? {
    string message = "Hello World, Ballerina";
    // Sends the message to the Kafka topic.
    check kafkaProducer->send({
                                topic: "test-kafka-topic",
                                value: message.toBytes() });

    // Flushes the sent messages.
    check kafkaProducer->'flush();
}
