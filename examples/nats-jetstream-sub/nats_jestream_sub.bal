import ballerina/log;
import ballerinax/nats;

// Initializes a NATS client.
nats:Client natsClient = check new(nats:DEFAULT_URL);

// Initializes a NATS JetStream listener.
listener nats:JetStreamListener subscription = new(newClient);

@nats:StreamServiceConfig {
    subject: "bbe.jetstream",
    autoAck: false
}
// Binds the consumer to listen to the messages published to the 'bbe.jetstream' subject.
service nats:StreamService on subscription {
    remote function onMessage(nats:JetStreamMessage message, nats:JetStreamCaller caller) returns error? {
        string messageContent = check string:fromBytes(message.content);
        log:printInfo("Received JetStream message: " + messageContent);
        check caller->ack();
    }
}
