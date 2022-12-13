import ballerina/http;
import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Creates a ballerina RabbitMQ client with username/password authentication.
final rabbitmq:Client orderClient = check new(rabbitmq:DEFAULT_HOST, 5672,
    // To secure the client connections using username/password authentication, provide the credentials
    // with the `rabbitmq:Credentials` record.
    auth = {
         username: "alice",
         password: "alice@123"
    }
);

service / on new http:Listener(9092) {

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        // Publishes the message using newClient and the routing key named OrderQueue.
        check orderClient->publishMessage({
            content: newOrder,
            routingKey: "OrderQueue"
        });

        return http:ACCEPTED;
    }
}
