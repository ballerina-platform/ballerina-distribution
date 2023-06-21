import ballerina/log;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initiate a NATS client passing the URL of the NATS broker.
nats:Client natsClient = check new (nats:DEFAULT_URL);

// Initialize a NATS JetStream listener.
listener nats:JetStreamListener subscription = new (natsClient);
const string SUBJECT_NAME = "orders";

@nats:StreamServiceConfig {
    subject: SUBJECT_NAME,
    autoAck: false
}
// Bind the consumer to listen to the messages published to the 'orders' subject.
service nats:JetStreamService on subscription {
    remote function onMessage(nats:JetStreamMessage message) returns error? {
        string stringContent = check string:fromBytes(message.content);
        json jsonContent = check stringContent.fromJsonString();
        Order 'order = check jsonContent.cloneWithType();
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
