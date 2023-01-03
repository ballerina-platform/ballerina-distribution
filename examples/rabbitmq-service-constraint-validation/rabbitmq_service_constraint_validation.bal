import ballerina/constraint;
import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {
    int orderId;
    // Add a constraint to allow only string values of length between 1 and 30.
    @constraint:String {maxLength: 30, minLength: 1}
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

    // When an error occurs, `onError` gets invoked.
    remote function onError(rabbitmq:AnydataMessage message, rabbitmq:Error err) {
        if err is rabbitmq:PayloadValidationError {
            log:printError("Payload validation failed", err);
        }
    }
}
