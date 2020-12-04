import ballerina/lang.'string;
import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener channelListener = new;

// The consumer service listens to the "MyQueue" queue.
// Quality of service settings(prefetchCount and prefetchSize) can be
// set at the listener initialization globally or per consumer service.
// These settings impose limits on the amount of data the server
// will deliver to consumers before requiring acknowledgements.
// Thus they provide a means of consumer-initiated flow control.
@rabbitmq:ServiceConfig {
    queueConfig: {
        queueName: "MyQueue"
    },
    ackMode: rabbitmq:CLIENT_ACK,
    prefetchCount: 10
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
