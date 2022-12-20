import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// The consumer service listens to the "OrderQueue" queue.
service "OrderQueue" on new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {

    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
