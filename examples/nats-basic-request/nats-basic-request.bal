import ballerina/io;
import ballerinax/nats;

public type Order record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public type StringMessage record {|
    *nats:AnydataMessage;
    string content;
|};

public function main() returns error? {
    nats:Client natsClient = check new (nats:DEFAULT_URL);

    // Sends a request and returns the reply.
    StringMessage reply = check natsClient->requestMessage({
        content: {
            orderId: 1,
            productName: "Sport shoe",
            price: 27.5,
            isValid: true
        },
        subject: "orders.valid"
    });

    io:println("Reply message: " + reply.content);
    check natsClient.close();
}
