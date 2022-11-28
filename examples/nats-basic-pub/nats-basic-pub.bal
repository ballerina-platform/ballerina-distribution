import ballerinax/nats;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns error? {
    // Initializes a NATS client.
    nats:Client natsClient = check new (nats:DEFAULT_URL);

    // Produces a message to the specified subject.
    check natsClient->publishMessage({content: { orderId: 1,
                                                 productName: "Sport shoe",
                                                 price: 27.5,
                                                 isValid: true
                                               }, subject: "orders.valid"});

    // Closes the client connection.
    check natsClient.close();
}
