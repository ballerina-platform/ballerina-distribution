import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "log-id",
    topics: "log-topic",
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

service on new kafka:Listener("localhost:9094", consumerConfigs) {
    remote function onConsumerRecord(string[] logs) returns error? {
        check from string log in logs
            do {
                log:printInfo(string `Received log: ${log}`);
            };
    }
}
