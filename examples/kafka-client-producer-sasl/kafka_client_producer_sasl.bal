import ballerina/io;
import ballerinax/kafka;

kafka:ProducerConfiguration producerConfig = {
    // Provide the relevant authentication configurations to authenticate the producer by `kafka:AuthenticationConfiguration`.
    // For details, see https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration.
    auth: {
        // Provide the authentication mechanism used by the Kafka server.
        mechanism: kafka:AUTH_SASL_PLAIN,
        // Username and password should be set here in order to authenticate the producer.
        // For information on how to secure values instead of directly using plain text values,
        // see https://ballerina.io/learn/by-example/configurable-variables.html.
        username: "alice",
        password: "alice@123"
    },
    securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
};

public function main() returns kafka:Error? {
    kafka:Producer messageProducer = check new ("localhost:9093", producerConfig);
    kafka:Error? result = messageProducer->send({
        topic: "log-topic",
        value: "login failed for user 212341 at 1669113239"
    });
    if result is kafka:Error {
        io:println("Message publish unsuccessful : " + result.message());
    } else {
        io:println("Message published successfully.");
    }
}
