import ballerinax/kafka;
import ballerina/log;

// The `kafka:AuthenticationConfiguration` is used to provide authentication-related details.
kafka:AuthenticationConfiguration authConfig = {
    // Provide the authentication mechanism used by the Kafka server.
    mechanism: kafka:AUTH_SASL_PLAIN,
    // Username and password should be set here in order to authenticate the consumer.
    // Check Ballerina `config` APIs to see how to use encrypted values instead of plain text values here.
    username: "ballerina",
    password: "ballerina-secret"

};

kafka:ConsumerConfiguration consumerConfig = {
    groupId:"test-group",
    clientId: "sasl-consumer",
    offsetReset:"earliest",
    topics:["topic-sasl"],
    // Provide the relevant authentication configuration record to authenticate the consumer.
    authenticationConfiguration: authConfig
};

listener kafka:Listener kafkaListener = new(kafka:DEFAULT_URL, consumerConfig);

service kafka:Service on kafkaListener {
    remote function onConsumerRecord(kafka:Caller caller,
                                kafka:ConsumerRecord[] records) {
        foreach var consumerRecord in records {
            string|error messageContent =
                                   string:fromBytes(consumerRecord.value);
            if (messageContent is string) {
                log:print(messageContent);
            }
        }
    }
}
