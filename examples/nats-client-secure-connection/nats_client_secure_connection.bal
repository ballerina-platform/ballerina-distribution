import ballerina/http;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS client with TLS/SSL.
final nats:Client orderClient = check new(nats:DEFAULT_URL,
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
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
