import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,

    // To secure the client connections using username/password authentication, provide the credentials
    // with the [`rabbitmq:Credentials`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials) record.
    auth = {
         username: "alice",
         password: "alice@123"
    },

    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    // The [`rabbitmq:SecureSocket`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
    // record provides the SSL-related configurations of the client.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

@rabbitmq:ServiceConfig {
    queueName: "Secured"
}
// Attaches the service to the listener.
service rabbitmq:Service on securedEP {
    remote function onMessage(rabbitmq:Message message) {
        string|error messageContent = string:fromBytes(message.content);
        if messageContent is string {
            log:printInfo("Received message: " + messageContent);
        }
    }
}
