import ballerinax/kafka;
import ballerina/log;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

listener kafka:Listener orderListener = check new ("localhost:9093", {
    groupId: "order-group-id",
    // Subscribes to the topic `test-kafka-topic`.
    topics: ["order-topic"],
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

service on orderListener {
    remote function onConsumerRecord(Order[] orders) returns error? {
        check from Order 'order in orders
            where 'order.isValid
            do {
                log:printInfo(string `Received valid order for ${'order.productName}`);
            };
    }
}
