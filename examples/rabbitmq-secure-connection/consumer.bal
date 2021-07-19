import ballerina/log;
import ballerinax/rabbitmq;

// To secure the client connection using TLS/SSL, the client needs to be configured with
// a certificate file of the server.
// The [`rabbitmq:SecureSocket`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
// record provides th   e SSL-related configurations of the client.
rabbitmq:SecureSocket sslConfig = { cert: "../resource/path/to/public.crt" };

// To secure the client connections using basic authentication, provide the credentials
// with the [`rabbitmq:Credentials`](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials) record.
rabbitmq:Credentials credentials = { username: "ballerina",
                                     password: "ballerina@123" };

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,
    auth = credentials, secureSocket = sslConfig);

@rabbitmq:ServiceConfig {
    queueName: "Secured"
}
// Attaches the service to the listener.
service rabbitmq:Service on securedEP {
    remote function onMessage(rabbitmq:Message message) {
        string|error messageContent = string:fromBytes(message.content);
        if (messageContent is string) {
            log:printInfo("Received message: " + messageContent);
        }
    }
}
