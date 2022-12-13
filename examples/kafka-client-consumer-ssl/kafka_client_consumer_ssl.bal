import ballerina/http;
import ballerinax/kafka;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Consumer orderConsumer = check new ("localhost:9094", {
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

service / on new http:Listener(9090) {
    resource function get orders() returns Order[]|kafka:Error {
        // Polls the consumer for payload.
        Order[] orders = check orderConsumer->pollPayload(1);

        return from Order 'order in orders
            where 'order.isValid
            select 'order;
    }
}
