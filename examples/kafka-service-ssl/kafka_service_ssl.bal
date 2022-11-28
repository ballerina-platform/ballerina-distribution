import ballerinax/kafka;
import ballerina/log;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

listener kafka:Listener orderListener = check new ("localhost:9094", {
    groupId: "order-group-id",
    topics: "order-topic",
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

service on orderListener {
    remote function onConsumerRecord(Order[] orders) returns error? {
        check from Order 'order in orders
            where 'order.isValid
            do {
                log:printInfo(string `Received valid order for ${'order.productName}`);
            };
    }
}
