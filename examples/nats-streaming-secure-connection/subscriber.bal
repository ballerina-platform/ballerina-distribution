import ballerina/log;
import ballerinax/stan;

// Initializes the NATS Streaming listener with TLS/SSL and username/password authentication.
listener stan:Listener securedEP = new(stan:DEFAULT_URL,
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

// Binds the consumer to listen to the messages published to the 'security.demo' subject.
@stan:ServiceConfig {
    subject: "security.demo"
}
service stan:Service on securedEP {
    remote function onMessage(stan:Message message) {
        // Prints the incoming message in the console.
        string|error messageData = string:fromBytes(message.content);
        if messageData is string {
            log:printInfo("Received message: " + messageData);
        }
    }
}
