import ballerina/constraint;
import ballerinax/rabbitmq;
import ballerina/log;

public type Order record {
    int orderId;
    // Add a constraint to only allow string values of length between 1 and 30.
    @constraint:String {maxLength: 30, minLength: 1}
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    // Creates a ballerina RabbitMQ client.
    rabbitmq:Client newClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);

    // Consuming message from the routing key OrderQueue.
    Order|rabbitmq:PayloadValidationError|rabbitmq:Error 'order = newClient->consumePayload("OrderQueue");
    if 'order is Order {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        } 
    } else if 'order is rabbitmq:PayloadValidationError {
        log:printError("Payload validation failed", 'order);
    } else {
        log:printError("Error occurred while consuming");    
    }
}
