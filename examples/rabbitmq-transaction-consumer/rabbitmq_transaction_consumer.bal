import ballerina/log;
import ballerinax/rabbitmq;

// The consumer service listens to the "MyQueue" queue.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue",
    autoAck: false
}
// Attaches the service to the listener.
service /transactionConsumer on
                    new rabbitmq:Listener({host: "localhost", port: 5672}) {

    // Gets triggered when a message is received by the queue.
    remote function onMessage(rabbitmq:Message message,
                                rabbitmq:Caller caller) {

        var messageContent = 'string:fromBytes(message.content);
        if (messageContent is string) {
            log:print("The message received: " + messageContent);
        } else {
            log:printError(
                       "Error occurred while retrieving the message content.");
        }
        // Acknowledges a single message positively.
        // The acknowledgement gets committed upon successful execution of the transaction,
        // or will rollback otherwise.
        transaction {
            var result = caller->basicAck();
            if (result is error) {
                log:printError(
                            "Error occurred while acknowledging the message.");
            }
            var res = commit;
        }
    }
}
