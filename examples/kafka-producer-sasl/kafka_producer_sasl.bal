import ballerina/http;
import ballerinax/kafka;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Producer orderProducer = check new ("localhost:9093", {
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

service / on new http:Listener(9090) {
    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|kafka:Error {
        check orderProducer->send({
            topic: "order-topic",
            value: newOrder
        });
        return http:ACCEPTED;
    }
}
