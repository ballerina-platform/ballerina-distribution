import ballerina/io;
import ballerinax/kafka;

// Define the relevant SASL URL of the configured Kafka server.
const string SASL_URL = "localhost:9093";

kafka:ProducerConfiguration producerConfig = {
    // Provide the relevant authentication configurations to authenticate the producer by [`kafka:AuthenticationConfiguration`](https://docs.central.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration).
    auth: {
        // Provide the authentication mechanism used by the Kafka server.
        mechanism: kafka:AUTH_SASL_PLAIN,
        // Username and password should be set here in order to authenticate the producer.
        // For information on how to secure values instead of directly using plain text values, see [Defining Configurable Variables](https://ballerina.io/learn/user-guide/configurability/defining-configurable-variables/#securing-sensitive-data-using-configurable-variables).
        username: "alice",
        password: "alice@123"
    },
    securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
};

kafka:Producer messageProducer = check new (SASL_URL, producerConfig);

public function main() {
    kafka:Error? result = messageProducer->send({
        topic: "demo-security",
        value: "Hello, World!"
    });
    if result is kafka:Error {
        io:println("Message publish unsuccessful : " + result.message());
    } else {
        io:println("Message published successfully.");
    }
}
