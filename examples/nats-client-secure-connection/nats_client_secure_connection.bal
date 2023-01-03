import ballerina/http;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9092) {
    private final nats:Client orderClient;

    function init() returns error? {
        // Initiate the NATS client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.orderClient = check new (nats:DEFAULT_URL,
            // To secure the client connection using TLS/SSL, the client needs to be configured with
            // a certificate file of the server.
            secureSocket = {
                cert: "../resource/path/to/public.crt"
            }
        );
    }

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        // Produces a message to the specified subject.
        check self.orderClient->publishMessage({
            content: newOrder,
            subject: "orders.valid"
        });

        return http:ACCEPTED;
    }
}
