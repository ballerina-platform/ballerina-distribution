import ballerinax/kafka;
import ballerina/log;

listener kafka:Listener securedEp = check new ("localhost:9094", {
    groupId: "log-group-id",
    topics: "log-topic",
    // Provide the relevant secure socket configurations by using `kafka:SecureSocket`.
    secureSocket: {
        cert: "./resources/path/to/public.crt",
        protocol: {
            // Provide the relevant security protocol.
            name: kafka:SSL
        }
    },
    // Provide the type of the security protocol to use in the broker connection.
    securityProtocol: kafka:PROTOCOL_SSL
});

service on securedEp {
    remote function onConsumerRecord(string[] logs) returns error? {
        check from string log in logs
            do {
                log:printInfo(string `Received log: ${log}`);
            };
    }
}
