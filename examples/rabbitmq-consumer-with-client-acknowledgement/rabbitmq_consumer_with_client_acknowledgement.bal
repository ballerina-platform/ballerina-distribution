import ballerina/lang.'string;
import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener channelListener = new;

// The consumer service listens to the "MyQueue" queue.
// The `ackMode` is by default rabbitmq:AUTO_ACK where messages are acknowledged
// immediately after consuming.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue"
}
// Attaches the service to the listener.
service rabbitmq:RabbitmqService on channelListener {
    remote function onMessage(rabbitmq:Message message, rabbitmq:Caller caller) {
        string|error messageContent = 'string:fromBytes(message.content);
        if (messageContent is string) {
            log:printInfo("The message received: " + messageContent);
        } else {
            log:printError(
                        "Error occurred while retrieving the message content.");
        }

        // Positively acknowledges a single message.
        var result = caller->basicAck();
    }
}
