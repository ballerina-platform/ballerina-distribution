import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "log-group-id",
    topics: "log-topic",
    // Provide the relevant authentication configurations to authenticate the consumer 
    // by the `kafka:AuthenticationConfiguration`.
    auth: {
        // Provide the authentication mechanism used by the Kafka server.
        mechanism: kafka:AUTH_SASL_PLAIN,
        // Username and password should be set here in order to authenticate the consumer.
        username: "alice",
        password: "alice@123"
    },
    securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
};

service on new kafka:Listener("localhost:9093", consumerConfigs) {
    remote function onConsumerRecord(string[] logs) returns error? {
        check from string log in logs
            do {
                log:printInfo("Received log: " + log);
            };
    }
}
