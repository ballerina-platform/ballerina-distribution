import ballerinax/nats;

public type Order record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

public function main() returns error? {
    // Initializes a NATS client with username/password authentication.
    nats:Client natsClient = check new(nats:DEFAULT_URL,

        // To secure the client connections using username/password authentication, provide the credentials
        // with the `nats:Credentials` record.
        auth = {
            username: "alice",
            password: "alice@123"
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
