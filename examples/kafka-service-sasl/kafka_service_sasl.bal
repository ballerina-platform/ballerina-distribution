import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "log-group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: "log-topic",
    // Provide the relevant authentication configurations to authenticate the consumer
    // by the `kafka:AuthenticationConfiguration`.
    // For details, see https://lib.ballerina.io/ballerinax/kafka/latest/records/AuthenticationConfiguration.
    auth: {
        // Provide the authentication mechanism used by the Kafka server.
        mechanism: kafka:AUTH_SASL_PLAIN,
        // Username and password should be set here in order to authenticate the consumer.
        // For information on how to secure values instead of directly using plain text values, see
        // https://ballerina.io/learn/by-example/configurable-variables.html.
        username: "alice",
        password: "alice@123"
    },
    securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
};

service on new kafka:Listener("localhost:9093", consumerConfigs) {
    remote function onConsumerRecord(string[] logs) returns error? {
        check from string log in logs
            do {
                log:printInfo(string `Received log: ${log}`);
            };
    }
}
