import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener channelListener = new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

// The consumer service listens to the "MyQueue" queue.
service "MyQueue" on channelListener {
    remote function onMessage(string message) returns error? {
        log:printInfo("Received message: " + message);
    }
}
