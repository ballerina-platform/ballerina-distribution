import ballerina/http;
import ballerinax/kafka;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9090) {
    private final kafka:Producer orderProducer;

    function init() returns error? {
        self.orderProducer = check new ("localhost:9094", {
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
    }

    resource function post orders(Order newOrder) returns http:Accepted|error {
        check self.orderProducer->send({
            topic: "order-topic",
            value: newOrder
        });
        return http:ACCEPTED;
    }
}
