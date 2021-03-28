import ballerina/io;
import ballerinax/kafka;

// The `kafka:AuthenticationConfiguration` is used to provide authentication-related details.
kafka:AuthenticationConfiguration authConfig = {
    // Provide the authentication mechanism used by the Kafka server.
    mechanism: kafka:AUTH_SASL_PLAIN,
    // Username and password should be set here in order to authenticate the producer.
    // Check Ballerina `config` APIs to see how to use encrypted values instead of plain text values here.
    username: "ballerina",
    password: "ballerina-secret"

};

kafka:ProducerConfiguration producerConfigs = {
    // Provide the relevant authentication configuration record to authenticate the producer.
    authenticationConfiguration: authConfig

};

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL, producerConfigs);

public function main() {
    string message = "Hello from Ballerina";
    var result = kafkaProducer->send({
                            topic: "topic-sasl",
                            value: message.toBytes() });
    if (result is error) {
        io:println(result);
    } else {
        io:println("Message successfully sent");
    }
}
