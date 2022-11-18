import ballerina/io;
import ballerinax/kafka;

// Define the relevant SSL URL of the configured Kafka server.
const SSL_URL = "localhost:9094";

kafka:ProducerConfiguration producerConfig = {
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

public function main() returns kafka:Error? {
    kafka:Producer messageProducer = check new (SSL_URL, producerConfig);
    kafka:Error? result = messageProducer->send({
        topic: "demo-security",
        value: "Hello, World!"
    });
    if result is kafka:Error {
        io:println("Message publish unsuccessful : " + result.message());
    } else {
        io:println("Message published successfully.");
    }
}
