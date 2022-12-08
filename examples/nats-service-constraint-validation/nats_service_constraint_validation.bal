import ballerina/constraint;
import ballerina/log;
import ballerinax/nats;

public type Order record {
    int orderId;
    // Add a constraint to only allow string values of length between 1 and 30.
    @constraint:String {maxLength: 30, minLength: 1}
    string productName;
    decimal price;
    boolean isValid;
};

// Binds the consumer to listen to the messages published to the 'orders.valid' subject.
service "orders.valid" on new nats:Listener(nats:DEFAULT_URL) {
    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }

    // When an error occurs `onError` gets invoked.
    remote function onError(nats:AnydataMessage message, nats:Error err) {
        if err is nats:PayloadValidationError {
            log:printError("Payload validation failed", err);
        }
    }
}
