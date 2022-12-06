import ballerina/log;
import ballerinax/rabbitmq;

listener rabbitmq:Listener securedEP = new(rabbitmq:DEFAULT_HOST, 5671,

    // To secure the listener connections using username/password authentication, provide the credentials
    // with the `rabbitmq:Credentials` record.
    auth = {
        username: "alice",
        password: "alice@123"
    }
);

// Attaches the service to the listener.
service "Secured" on securedEP {
    remote function onMessage(string message) returns error? {
        log:printInfo("Received message: " + message);
    }
}
