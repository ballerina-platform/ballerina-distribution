import ballerina/log;
import ballerinax/rabbitmq;

// The consumer service listens to the "MyQueue" queue.
// The `ackMode` is by default rabbitmq:AUTO_ACK where messages are acknowledged
// immediately after consuming.
@rabbitmq:ServiceConfig {
    queueName: "OrderQueue",
    autoAck: false
}
// Attaches the service to the listener.
service rabbitmq:Service on new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {
    remote function onMessage(StringMessage message, rabbitmq:Caller caller) returns error? {
        log:printInfo("Received message: " + message.content);
        // Positively acknowledges a single message.
        check caller->basicAck();
    }
}

public type StringMessage record {|
    *rabbitmq:AnydataMessage;
    string content;
|};
