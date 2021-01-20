import ballerina/lang.'string;
import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener channelListener = checkpanic new;

// The consumer service listens to the "MyQueue" queue.
// The `ackMode` is by default rabbitmq:AUTO_ACK where messages are acknowledged
// immediately after consuming.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue"
}
// Attaches the service to the listener.
service rabbitmq:Service on channelListener {
    remote function onMessage(rabbitmq:Message message) {
        string|error messageContent = 'string:fromBytes(message.content);
        if (messageContent is string) {
            log:print("The message received: " + messageContent);
        } else {
            log:printError(
                        "Error occurred while retrieving the message content.");
        }
    }
}
