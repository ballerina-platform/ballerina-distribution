import ballerinax/kafka;

public type Order readonly & record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns kafka:Error? {
    kafka:Producer orderProducer = check new ("localhost:9093", {
        // Provide the relevant authentication configurations to authenticate the producer by
        // `kafka:AuthenticationConfiguration`.
        auth: {
            // Provide the authentication mechanism used by the Kafka server.
            mechanism: kafka:AUTH_SASL_PLAIN,
            // Username and password should be set here in order to authenticate the producer.
            username: "alice",
            password: "alice@123"
        },
        securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
    });
    check orderProducer->send({
        topic: "order-topic",
        value: {
            orderId: 1,
            productName: "Sport shoe",
            price: 27.5,
            isValid: true
        }
    });
}
