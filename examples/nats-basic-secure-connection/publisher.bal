import ballerinax/nats;

public function main() returns error? {
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    // The [`nats:SecureSocket`](https://docs.central.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
    // record provides th   e SSL-related configurations of the client.
    nats:SecureSocket sslConfig = { cert: "../resource/path/to/public.crt" };

    // To secure the client connections using basic authentication, provide the credentials
    // with the [`nats:Credentials`](https://docs.central.ballerina.io/ballerinax/nats/latest/records/Credentials) record.
    nats:Credentials credentials = { username: "ballerina",
                                     password: "ballerina@123" };

    string message = "Hello from Ballerina";
    // Initializes a NATS client with TLS/SSL and basic authentication.
    nats:Client natsClient = check new(nats:DEFAULT_URL, auth = credentials,
                                                secureSocket = sslConfig);

    // Produces a message to the specified subject.
    check natsClient->publishMessage({
                             content: message.toBytes(),
                             subject: "security.demo"});

    // Closes the client connection.
    check natsClient.close();
}
