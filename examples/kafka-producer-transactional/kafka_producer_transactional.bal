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

kafka:Producer transactionalProducer =
                check new (kafka:DEFAULT_URL, producerConfigs);

public function main() returns error? {
    transaction {
        // Sends the message inside the transaction block.
        check transactionalProducer->send({
            topic: "test-kafka-topic",
            value: "Hello World Transaction Message"
        });

        check commit;
    }
}
