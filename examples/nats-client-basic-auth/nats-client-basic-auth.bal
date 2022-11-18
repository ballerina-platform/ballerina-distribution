import ballerinax/nats;

public function main() returns error? {
    string message = "Hello from Ballerina";

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
    check natsClient->publishMessage({content: message.toBytes(), subject: "security.demo"});

    // Closes the client connection.
    check natsClient.close();
}
