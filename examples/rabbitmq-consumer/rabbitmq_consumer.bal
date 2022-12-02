import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener channelListener = new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

// The consumer service listens to the "MyQueue" queue.
// The `ackMode` is by default rabbitmq:AUTO_ACK where messages are acknowledged
// immediately after consuming.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue"
}
// Attaches the service to the listener.
service on channelListener {
    remote function onMessage(StringMessage message) returns error? {
        log:printInfo("Received message: " + message.content);
    }
}

public type StringMessage record {|
    *rabbitmq:AnydataMessage;
    string content;
|};
