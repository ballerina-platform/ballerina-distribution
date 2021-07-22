import ballerina/io;
import ballerinax/stan;

// Produces a message to a subject in the NATS streaming sever.
public function main() returns error? {
    string message = "Hello from Ballerina";

    // Initializes the NATS Streaming client with TLS/SSL and username/password authentication.
    stan:Client stanClient = check new(stan:DEFAULT_URL,
        clusterId = "my_secure_cluster",

        // To secure the client connections using username/password authentication, provide the credentials
        // with the [`stan:Credentials`](https://docs.central.ballerina.io/ballerinax/stan/latest/records/Credentials) record.
        auth = {
             username: "alice",
             password: "alice@123"
        },

        // To secure the client connection using TLS/SSL, the client needs to be configured with
        // a certificate file of the server.
        // The [`stan:SecureSocket`](https://docs.central.ballerina.io/ballerinax/stan/latest/records/SecureSocket)
        // record provides the SSL-related configurations of the client.
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );

    // Produces a message to the specified subject.
    string result = check stanClient->publishMessage({
                                    content: message.toBytes(),
                                    subject: "demo"});
    io:println("GUID " + result + " received for the produced message.");
    // Closes the client connection.
    check stanClient.close();
}
