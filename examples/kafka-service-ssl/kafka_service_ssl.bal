import ballerinax/kafka;
import ballerina/log;

// Define the relevant SSL URL of the configured Kafka server.
const SSL_URL = "localhost:9094";

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["test-kafka-topic"],
    pollingInterval: 1,
    // Provide the relevant secure socket configurations by using `kafka:SecureSocket`.
    // For details, see https://lib.ballerina.io/ballerinax/kafka/latest/records/SecureSocket.
    secureSocket: {
        cert: "./resources/path/to/public.crt",
        protocol: {
            // Provide the relevant security protocol.
            name: kafka:SSL
        }
    },
    // Provide the type of the security protocol to use in the broker connection.
    securityProtocol: kafka:PROTOCOL_SSL
};

service on new kafka:Listener(SSL_URL, consumerConfigs) {
    remote function onConsumerRecord(string[] values) returns error? {
        check from string value in values
            do {
                log:printInfo(string `Received value: ${value}`);
            };
    }
}
