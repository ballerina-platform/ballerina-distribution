import ballerina/log;
import ballerinax/nats;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS JetStream listener.
listener nats:JetStreamListener subscription = new (check new nats:Client(nats:DEFAULT_URL));
const string SUBJECT_NAME = "orders";

@nats:StreamServiceConfig {
    subject: SUBJECT_NAME,
    autoAck: false
}
// Binds the consumer to listen to the messages published to the 'bbe.jetstream' subject.
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
