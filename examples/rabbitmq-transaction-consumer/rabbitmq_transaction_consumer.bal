import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

// The consumer service listens to the "MyQueue" queue.
@rabbitmq:ServiceConfig {
    queueName: "MyQueue",
    autoAck: false
}
// Attaches the service to the listener.
service on new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {
    remote function onMessage(Order 'order, rabbitmq:Caller caller) returns error? {
        // Acknowledges a single message positively.
        transaction {
            if 'order.isValid {
                log:printInfo(string `Received valid order for ${'order.productName}`);
                rabbitmq:Error? result = caller->basicAck();
                if result is error {
                    log:printError("Error occurred while acknowledging the message.");
                }
            }
            check commit;
        }
    }
}

public type StringMessage record {|
    *rabbitmq:AnydataMessage;
    string content;
|};
