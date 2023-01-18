import ballerina/log;
import ballerinax/rabbitmq;

public type StringMessage record {|
    *rabbitmq:AnydataMessage;
    string content;
|};

// The consumer service listens to the "MyQueue" queue.
@rabbitmq:ServiceConfig {
    queueName: "OrderQueue",
    autoAck: false
}
service on new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {
    remote function onMessage(StringMessage message, rabbitmq:Caller caller) returns error? {
        // Acknowledges a single message positively.
        transaction {
            log:printInfo("Received message: " + message.content);

            // Positively acknowledges a single message.
            check caller->basicAck();
            check commit;
        }
    }
}
