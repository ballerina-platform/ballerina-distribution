import ballerina/log;
import ballerinax/nats;

// Initializes a NATS listener with TLS/SSL and username/password authentication.
listener nats:Listener securedEP = new(nats:DEFAULT_URL,

    // To secure the client connections using username/password authentication, provide the credentials
    // with the `nats:Credentials` record.
    // For details, see  https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials.
    auth = {
         username: "alice",
         password: "alice@123"
    },
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    // The [`nats:SecureSocket` record provides the SSL-related configurations of the client.
    // For details, see https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

// Binds the consumer to listen to the messages published to the 'security.demo' subject.
service "security.demo" on securedEP {
    remote function onMessage(nats:Message message) returns error? {
        string messageContent = check string:fromBytes(message.content);
        log:printInfo("Received message: " + messageContent);
    }
}
