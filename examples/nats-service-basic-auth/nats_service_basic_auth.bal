import ballerina/log;
import ballerinax/nats;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS listener with TLS/SSL and username/password authentication.
listener nats:Listener securedEP = new(nats:DEFAULT_URL,
    // To secure the client connections using username/password authentication, provide the credentials
    // with the `nats:Credentials` record.
    auth = {
         username: "alice",
         password: "alice@123"
    }
);

// Binds the consumer to listen to the messages published to the 'orders.valid' subject.
service "orders.valid" on securedEP {
    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
