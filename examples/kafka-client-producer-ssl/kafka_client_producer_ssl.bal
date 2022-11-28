import ballerinax/kafka;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns kafka:Error? {
    kafka:Producer orderProducer = check new ("localhost:9094", {
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
