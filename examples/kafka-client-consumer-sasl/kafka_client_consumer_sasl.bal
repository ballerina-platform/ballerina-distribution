import ballerinax/kafka;
import ballerina/io;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new ("localhost:9093", {
        groupId: "order-group-id",
        topics: "order-topic",
        // Provide the relevant authentication configurations to authenticate the consumer
        // by the `kafka:AuthenticationConfiguration`.
        auth: {
            // Provide the authentication mechanism used by the Kafka server.
            mechanism: kafka:AUTH_SASL_PLAIN,
            // Username and password should be set here in order to authenticate the consumer.
            username: "alice",
            password: "alice@123"
        },
        securityProtocol: kafka:PROTOCOL_SASL_PLAINTEXT
    });

    // Polls the consumer for payload.
    Order[] orders = check logConsumer->pollPayload(1);

    check from Order 'order in orders
        do {
            io:println(string `Received valid order for ${'order.productName}`);
        };
}
