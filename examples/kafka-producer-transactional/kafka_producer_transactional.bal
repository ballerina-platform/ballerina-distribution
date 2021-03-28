import ballerina/io;
import ballerinax/kafka;

kafka:ProducerConfiguration producerConfigs = {
    clientId: "basic-producer",
    acks: "all",
    retryCount: 3,
    // The `enableIdempotence` should set to `true` to make a producer
    // transactional.
    enableIdempotence: true,

    // A `transactionalId` must be provided to make a producer transactional.
    transactionalId: "test-transactional-id"

};

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL, producerConfigs);

public function main() {
    string message = "Hello World Transaction Message";
    byte[] serializedMessage = message.toBytes();

    // Here, we create a producer config with optional parameters.
    // transactional.id - enable transactional message production.
    kafkaAdvancedTransactionalProduce(serializedMessage);

}

function kafkaAdvancedTransactionalProduce(byte[] message) {
    transaction {
        var sendResult = kafkaProducer->send({
            topic: "test-kafka-topic",
            value: message,
            partition: 0 });
        if (sendResult is error) {
            io:println("Kafka producer failed to send first message",
                sendResult.toString());
        }
        var commitResult = commit;
        if (commitResult is ()) {
            io:println("Transaction successful");
        } else {
            io:println("Transaction unsuccessful. " + commitResult.message());
        }
    }
}
