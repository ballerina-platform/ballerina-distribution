import ballerina/log;
import ballerinax/stan;

// To secure the client connection using TLS/SSL, the client needs to be configured with
// a certificate file of the server.
// The [`stan:SecureSocket`](https://docs.central.ballerina.io/ballerinax/stan/latest/records/SecureSocket)
// record provides th   e SSL-related configurations of the client.
stan:SecureSocket sslConfig = { cert: "../resource/path/to/public.crt" };

// To secure the client connections using basic authentication, provide the credentials
// with the [`stan:Credentials`](https://docs.central.ballerina.io/ballerinax/stan/latest/records/Credentials) record.
stan:Credentials credentials = { username: "ballerina",
                                 password: "ballerina@123" };

// Initializes the NATS Streaming listener with TLS/SSL and basic authentication.
listener stan:Listener lis = new(stan:DEFAULT_URL,
            clusterId = "my_secure_cluster", auth = credentials,
            secureSocket = sslConfig);

// Binds the consumer to listen to the messages published to the 'security.demo' subject.
@stan:ServiceConfig {
    subject: "security.demo"
}
service stan:Service on lis {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Received message: " + messageData);
        }
    }
}
