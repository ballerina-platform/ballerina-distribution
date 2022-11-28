import ballerinax/nats;

public function main() returns error? {
    // Initializes a NATS client with TLS/SSL and username/password authentication.
    nats:Client natsClient = check new(nats:DEFAULT_URL,

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        // The `nats:SecureSocket` record provides the SSL-related configurations of the client.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    check natsClient.close();
}
