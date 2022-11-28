import ballerina/log;
import ballerinax/nats;

// Binds the consumer to listen to the messages published to the 'demo.bbe' subject.
service "demo.bbe" on new nats:Listener(nats:DEFAULT_URL) {
    remote function onMessage(string message) returns error? {
        // Logs the incoming message.
        log:printInfo("Received message: " + message);
    }
}
