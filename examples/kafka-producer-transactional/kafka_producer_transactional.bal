import ballerinax/kafka;

// Creates a producer config with optional parameters.
// The `transactionalId` enables transactional message production.
kafka:ProducerConfiguration producerConfigs = {
    clientId: "basic-producer",
    acks: "all",
    retryCount: 3,
    // The `enableIdempotence` should set to `true` to make a producer transactional.
    enableIdempotence: true,

    // A `transactionalId` must be provided to make a producer transactional.
    transactionalId: "test-transactional-id"
};

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL, producerConfigs);

public function main() returns error? {
    string message = "Hello World Transaction Message";
    transaction {
        // Sends the message inside the transaction block.
        check kafkaProducer->send({
            topic: "test-kafka-topic",
            value: message,
            partition: 0
        });

        check commit;
    }
}
