import ballerinax/kafka;
import ballerina/io;

public function main() returns error? {
    kafka:Consumer logConsumer = check new ("localhost:9093", {
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
    });

    // Polls the consumer for payload.
    string[] logs = check logConsumer->pollPayload(1);

    check from string log in logs
        do {
            io:println(string `Received log: ${log}`);
        };
}
