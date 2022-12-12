import ballerina/log;
import ballerinax/rabbitmq;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,

    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

// The consumer service listens to the "OrderQueue" queue.
service "OrderQueue" on securedEP {
    remote function onMessage(Order 'order) returns error? {
        if 'order.isValid {
            log:printInfo(string `Received valid order for ${'order.productName}`);
        }
    }
}
