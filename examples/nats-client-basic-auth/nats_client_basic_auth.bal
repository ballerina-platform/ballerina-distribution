import ballerina/http;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS client.
final nats:Client orderClient = check new(nats:DEFAULT_URL,
    // To secure the client connections using username/password authentication, provide the credentials
    // with the `nats:Credentials` record.
    auth = {
        username: "alice",
        password: "alice@123"
    }
);

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
