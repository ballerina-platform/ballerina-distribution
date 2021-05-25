import ballerinax/kafka;
import ballerina/log;

// The `kafka:AuthenticationConfiguration` is used to provide authentication-related details.
kafka:AuthenticationConfiguration authConfig = {
    // Provide the authentication mechanism used by the Kafka server.
    mechanism: kafka:AUTH_SASL_PLAIN,
    // Username and password should be set here in order to authenticate the consumer.
    // For information on how to secure values instead of directly using plain text values, see [Writing Secure Ballerina Code](https://ballerina.io/learn/user-guide/security/writing-secure-ballerina-code/#securing-sensitive-data-using-configurable-variables).
    username: "ballerina",
    password: "ballerina-secret"
};

kafka:ConsumerConfiguration consumerConfig = {
    groupId: "test-group",
    clientId: "sasl-consumer",
    offsetReset: "earliest",
    topics: ["topic-sasl"],
    // Provide the relevant authentication configuration record to authenticate the consumer.
    auth: authConfig
};

listener kafka:Listener kafkaListener = new(kafka:DEFAULT_URL, consumerConfig);

service kafka:Service on kafkaListener {
    remote function onConsumerRecord(kafka:Caller caller,
                                kafka:ConsumerRecord[] records) {
        // Loops through the received consumer records.
        foreach var consumerRecord in records {
            // Converts the `byte[]` to a `string`.
            string messageContent = check
                                        string:fromBytes(consumerRecord.value);
            log:printInfo(messageContent);
        }
    }
}
