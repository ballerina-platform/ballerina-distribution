import ballerinax/kafka;
import ballerina/lang.'string;
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
    bootstrapServers:"localhost:9092",
    groupId:"test-group",
    clientId: "sasl-consumer",
    offsetReset:"earliest",
    topics:["topic-sasl"],
    valueDeserializerType: kafka:DES_BYTE_ARRAY,
    // Provide the relevant authentication configuration record to authenticate the consumer.
    authenticationConfiguration: authConfig
};

listener kafka:Listener kafkaListener = checkpanic new(consumerConfig);

service kafka:Service on kafkaListener {
    remote function onMessage(kafka:Caller caller,
                                kafka:ConsumerRecord[] records) {
        foreach var consumerRecord in records {
            string|error messageContent =
                                   'string:fromBytes(consumerRecord.value);
            if (messageContent is string) {
                log:print(messageContent);
            }
        }
    }
}
