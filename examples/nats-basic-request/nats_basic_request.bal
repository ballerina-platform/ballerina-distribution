import ballerina/http;
import ballerina/log;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public type StringMessage record {|
    *nats:AnydataMessage;
    string content;
|};

service / on new http:Listener(9092) {
    private final nats:Client orderClient;

    function init() returns error? {
        // Initiate the NATS client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.orderClient = check new (nats:DEFAULT_URL);
    }

    resource function post orders(Order newOrder) returns http:Accepted|error {
    
        // Sends a request and returns the reply.
        StringMessage reply = check self.orderClient->requestMessage({
            content: newOrder,
            subject: "orders.valid"
        });

        log:printInfo("Reply message: " + reply.content);
        return http:ACCEPTED;
    }
}
