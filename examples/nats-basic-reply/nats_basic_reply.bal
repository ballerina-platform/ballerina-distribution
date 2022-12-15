import ballerina/log;
import ballerinax/nats;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Binds the consumer to listen to the messages published to the 'demo.bbe' subject.
service "orders.valid" on new nats:Listener(nats:DEFAULT_URL) {
    remote function onRequest(Order 'order) returns string|error {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
            return "Received valid order!";
        } else {
            return "Received invalid order!";
        }
    }
}
