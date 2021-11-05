import ballerinax/nats;

public function main() returns error? {
    string message = "Hello from Ballerina";
    // Initializes a NATS client.
    nats:Client natsClient = check new(nats:DEFAULT_URL);

    // Produces a message to the specified subject.
    check natsClient->publishMessage({
                             content: message.toBytes(),
                             subject: "demo.bbe"});

    // Closes the client connection.
    check natsClient.close();
}
