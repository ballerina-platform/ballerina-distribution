import ballerina/io;
import ballerinax/kafka;

kafka:ProducerConfiguration producerConfig = {
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
};

public function main() returns kafka:Error? {
    kafka:Producer messageProducer = check new ("localhost:9094", producerConfig);
    kafka:Error? result = messageProducer->send({
        topic: "log-topic",
        value: "login failed for user 212341 at 1669113239"
    });
    if result is kafka:Error {
        io:println("Message publish unsuccessful : " + result.message());
    } else {
        io:println("Message published successfully.");
    }
}
