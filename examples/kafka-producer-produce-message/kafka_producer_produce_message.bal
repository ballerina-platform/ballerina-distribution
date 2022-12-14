import ballerinax/kafka;
import ballerina/http;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

final kafka:Producer orderProducer = check new (kafka:DEFAULT_URL);

service / on new http:Listener(9090) {
    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|kafka:Error {
        check orderProducer->send({
            topic: "order-topic",
            value: newOrder
        });
        return http:ACCEPTED;
    }
}
