import ballerinax/kafka;
import ballerina/io;

public function main() returns error? {
    kafka:Consumer logConsumer = check new ("localhost:9094", {
        groupId: "order-log-group-id",
        topics: ["order-log-topic"],
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

    // Polls the consumer for payload.
    string[] logs = check logConsumer->pollPayload(1);

    check from string log in logs
        do {
            io:println(string `Received log: ${log}`);
        };
}
