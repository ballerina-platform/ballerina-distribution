import ballerina/io;
import ballerinax/kafka;

public function main() returns kafka:Error? {
    kafka:Producer messageProducer = check new ("localhost:9093", {
        // Provide the relevant authentication configurations to authenticate the producer by
        // `kafka:AuthenticationConfiguration`.
        auth: {
            // Provide the authentication mechanism used by the Kafka server.
            mechanism: kafka:AUTH_SASL_PLAIN,
            // Username and password should be set here in order to authenticate the producer.
            username: "alice",
            password: "alice@123"
        },
        securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
    });
    check messageProducer->send({
        topic: "order-log-topic",
        value: "new order for item 2311 was placed on 1669113239"
    });
}
