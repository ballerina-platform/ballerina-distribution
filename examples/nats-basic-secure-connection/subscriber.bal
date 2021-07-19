import ballerina/log;
import ballerinax/nats;

// Initializes a NATS listener with TLS/SSL and basic authentication.
listener nats:Listener subscription = new(nats:DEFAULT_URL,

    // To secure the client connections using basic authentication, provide the credentials
    // with the [`nats:Credentials`](https://docs.central.ballerina.io/ballerinax/nats/latest/records/Credentials) record.
    auth = {
         username: "alice",
         password: "alice@123"
    },

    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    // The [`nats:SecureSocket`](https://docs.central.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
    // record provides the SSL-related configurations of the client.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

// Binds the consumer to listen to the messages published
// to the 'security.demo' subject.
service "security.demo" on subscription {

    remote function onMessage(nats:Message message) returns error? {
        string|error messageContent = string:fromBytes(message.content);
        if messageContent is string {
            log:printInfo("Received message: " + messageContent);
        }
    }
}
