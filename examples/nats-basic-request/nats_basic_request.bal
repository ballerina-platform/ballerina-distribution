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

// Initializes a NATS client.
final nats:Client orderClient = check new (nats:DEFAULT_URL);

service / on new http:Listener(9092) {

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
    
        // Sends a request and returns the reply.
        StringMessage reply = check orderClient->requestMessage({
            content: newOrder,
            subject: "orders.valid"
        });

        log:printInfo("Reply message: " + reply.content);
        return http:ACCEPTED;
    }
}
