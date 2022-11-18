import ballerina/log;
import ballerinax/nats;

// Initializes a NATS listener with TLS/SSL and username/password authentication.
listener nats:Listener securedEP = new(nats:DEFAULT_URL,

    // To secure the client connections using username/password authentication, provide the credentials
    // with the `nats:Credentials` record.
    auth = {
         username: "alice",
         password: "alice@123"
    }
);

// Binds the consumer to listen to the messages published to the 'security.demo' subject.
service "security.demo" on securedEP {
    remote function onMessage(string message) returns error? {
        log:printInfo("Received message: " + message);
    }
}
