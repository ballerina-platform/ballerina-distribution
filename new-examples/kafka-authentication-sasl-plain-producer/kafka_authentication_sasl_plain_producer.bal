import ballerina/io;
import ballerinax/kafka;

// The `kafka:AuthenticationConfiguration` is used to provide authentication-related details.
kafka:AuthenticationConfiguration authConfig = {
    // Provide the authentication mechanism used by the Kafka server.
    mechanism: kafka:AUTH_SASL_PLAIN,
    // Username and password should be set here in order to authenticate the producer.
    // For information on how to secure values instead of directly using plain text values, see [Writing Secure Ballerina Code](https://ballerina.io/learn/user-guide/security/writing-secure-ballerina-code/#securing-sensitive-data-using-configurable-variables).
    username: "ballerina",
    password: "ballerina-secret"
};

kafka:ProducerConfiguration producerConfigs = {
    // Provide the relevant authentication configuration record to authenticate the producer.
    auth: authConfig
};

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL, producerConfigs);

public function main() {
    string message = "Hello from Ballerina";
    kafka:Error? err = kafkaProducer->send({
        topic: "topic-sasl",
        value: message.toBytes()
    });
    // Checks for an error and notifies if an error has occurred.
    if err is kafka:Error {
        io:println("Error occurred when sending message ", 'error = err);
    } else {
        io:println("Message successfully sent.");
    }
}
