import ballerina/io;
import ballerinax/kafka;

public function main() returns kafka:Error? {
    kafka:Producer messageProducer = check new ("localhost:9094", {
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
    check messageProducer->send({
        topic: "order-log-topic",
        value: "new order for item 2311 was placed on 1669113239"
    });
}
