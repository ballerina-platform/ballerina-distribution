import ballerinax/kafka;
import ballerina/log;

listener kafka:Listener securedEp = check new ("localhost:9093", {
    groupId: "order-log-group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["order-log-topic"],
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
});

service on securedEp {
    remote function onConsumerRecord(string[] logs) returns error? {
        check from string log in logs
            do {
                log:printInfo(string `Received log: ${log}`);
            };
    }
}
