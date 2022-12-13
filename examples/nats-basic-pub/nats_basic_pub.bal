import ballerina/http;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS client.
final nats:Client orderClient = check new (nats:DEFAULT_URL);

service / on new http:Listener(9092) {

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        // Produces a message to the specified subject.
        check orderClient->publishMessage({
            content: newOrder,
            subject: "orders.valid"
        });

        return http:ACCEPTED;
    }
}
