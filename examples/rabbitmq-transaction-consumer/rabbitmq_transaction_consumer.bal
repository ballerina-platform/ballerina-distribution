import ballerina/log;
import ballerinax/rabbitmq;

// The consumer service listens to the "MyQueue" queue.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue",
    autoAck: false
}
// Attaches the service to the listener.
service /transactionConsumer on
    new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {

    // Gets triggered when a message is received by the queue.
    remote function onMessage(rabbitmq:Message message,
                        rabbitmq:Caller caller) returns error? {

        string|error messageContent = 'string:fromBytes(message.content);
        if messageContent is string {
            log:printInfo("The message received: " + messageContent);
        }

        // Acknowledges a single message positively.
        // The acknowledgement gets committed upon successful execution of the transaction,
        // or will rollback otherwise.
        transaction {
            rabbitmq:Error? result = caller->basicAck();
            if result is error {
                log:printError(
                            "Error occurred while acknowledging the message.");
            }
            check commit;
        }
    }
}
