import ballerinax/kafka;
import ballerina/http;

public type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9090) {
    private final kafka:Producer orderProducer;

    function init() returns error? {
        self.orderProducer = check new (kafka:DEFAULT_URL);
    }

    resource function post orders(@http:Payload anydata newOrder) returns http:Accepted|error {
        check self.orderProducer->send({
            topic: "order-topic",
            value: newOrder
        });
        return http:ACCEPTED;
    }
}
