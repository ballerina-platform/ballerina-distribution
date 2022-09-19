import ballerinax/nats;

public function main() returns error? {
    string message = "Hello from Ballerina";

    // Initializes a NATS client with TLS/SSL and username/password authentication.
    nats:Client natsClient = check new(nats:DEFAULT_URL,

        // To secure the client connections using username/password authentication, provide the credentials
        // with the `nats:Credentials` record.
        // For details, see https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials.
        auth = {
            username: "alice",
            password: "alice@123"
        },
        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        // The `nats:SecureSocket` record provides the SSL-related configurations of the client.
        // For details see https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    // Produces a message to the specified subject.
    check natsClient->publishMessage({content: message.toBytes(), subject: "security.demo"});

    // Closes the client connection.
    check natsClient.close();
}
