import ballerinax/nats;

// Produces a message to a subject in the NATS sever.
public function main() returns error? {
    string message = "Hello from Ballerina";
    // Initializes a client.
    nats:Client natsClient = check new;
    // Produces a message to the specified subject.
    check natsClient->publishMessage({
                             content: <@untainted>message.toBytes(),
                             subject: "demo.bbe.subject"});

    // Closes the client connection.
    check natsClient.close();
}
