import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,
    // Provide the credentials to secure the listener connections using username/password authentication.
    // with the `rabbitmq:Credentials` record.
    auth = {
        username: "alice",
        password: "alice@123"
    }
);

// The consumer service listens to the `OrderQueue` queue.
service "OrderQueue" on securedEP {

    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
