import ballerinax/kafka;

kafka:ProducerConfiguration producerConfiguration = {
    // The `bootstrapServers` is the list of remote server endpoints of the
    // Kafka brokers.
    bootstrapServers: "localhost:9092",

    clientId: "basic-producer",
    acks: "all",
    retryCount: 3
};

kafka:Producer kafkaProducer = checkpanic new (producerConfiguration);

public function main() returns error? {
    string message = "Hello World, Ballerina";
    // Send the message to the Kafka topic
    check kafkaProducer->send({
                                topic: "test-kafka-topic",
                                value: message.toBytes() });
    // Flush the sent messages
    check kafkaProducer->'flush();
}
