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
