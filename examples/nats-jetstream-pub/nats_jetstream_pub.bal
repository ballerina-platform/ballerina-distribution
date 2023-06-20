import ballerina/http;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9092) {
    private final string SUBJECT_NAME = "orders";
    private final nats:JetStreamClient orderClient;

    function init() returns error? {
        // Initiate a NATS client passing the URL of the NATS broker.
        nats:Client natsClient = check new (nats:DEFAULT_URL);

        // Initiate the NATS JetStreamClient at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.orderClient = check new (natsClient);
        nats:StreamConfiguration config = {
            name: "demo",
            subjects: [self.SUBJECT_NAME],
            storageType: nats:MEMORY
        };
        _ = check self.orderClient->addStream(config);
    }

    resource function post orders(Order newOrder) returns http:Accepted|error {
        // Produces a message to the specified subject.
        check self.orderClient->publishMessage({
            subject: self.SUBJECT_NAME,
            content: newOrder.toString().toBytes()
        });
        return http:ACCEPTED;
    }
}
