import ballerinax/kafka;
import ballerina/io;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new ("localhost:9094", {
        groupId: "order-group-id",
        topics: ["order-topic"],
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
    Order[] orders = check orderConsumer->pollPayload(1);

    check from Order 'order in orders
        do {
            io:println(string `Received valid order for ${'order.productName}`);
        };
}
