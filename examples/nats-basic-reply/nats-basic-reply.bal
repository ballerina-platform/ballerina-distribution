import ballerina/log;
import ballerinax/nats;

// Binds the consumer to listen to the messages published to the 'demo.bbe' subject.
service "demo.bbe" on new nats:Listener(nats:DEFAULT_URL) {
    remote function onRequest(string message) returns string|error {
        // Logs the incoming message.
        log:printInfo("Received message: " + message);
        // Sends the reply message to the `replyTo` subject of the received message.
        return "Hello Back!";
    }
}
