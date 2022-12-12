import ballerinax/nats;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    // Initializes a NATS client with TLS/SSL and username/password authentication.
    nats:Client natsClient = check new(nats:DEFAULT_URL,

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    // Produces a message to the specified subject.
    check natsClient->publishMessage({
        content: {
            orderId: 1,
            productName: "Sport shoe",
            price: 27.5,
            isValid: true
        },
        subject: "orders.valid"
    });

    check natsClient.close();
}
