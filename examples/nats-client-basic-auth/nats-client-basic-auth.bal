import ballerinax/nats;

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


    check natsClient.close();
}
