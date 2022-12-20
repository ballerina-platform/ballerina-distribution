import ballerina/log;
import ballerinax/nats;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Initializes a NATS listener with TLS/SSL and username/password authentication.
listener nats:Listener orderListener = new(nats:DEFAULT_URL,
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

// Binds the consumer to listen to the messages published to the 'orders.valid' subject.
service "orders.valid" on orderListener {

    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
