import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

// Attaches the service to the listener.
service "Secured" on securedEP {
    remote function onMessage(string message) returns error? {
        log:printInfo("Received message: " + message);
    }
}
