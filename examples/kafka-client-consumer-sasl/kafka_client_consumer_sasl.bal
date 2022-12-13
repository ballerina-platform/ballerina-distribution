import ballerina/http;
import ballerinax/kafka;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Consumer orderConsumer = check new ("localhost:9093", {
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

service / on new http:Listener(9090) {
    resource function get orders() returns Order[]|kafka:Error {
        // Polls the consumer for payload.
        Order[] orders = check orderConsumer->pollPayload(1);

        return from Order 'order in orders
            where 'order.isValid
            select 'order;
    }
}
