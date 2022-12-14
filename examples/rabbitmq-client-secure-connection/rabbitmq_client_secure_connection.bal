import ballerina/http;
import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

// Creates a ballerina RabbitMQ client with TLS/SSL.
final rabbitmq:Client orderClient = check new(rabbitmq:DEFAULT_HOST, 5671,
    // To secure the client connection using TLS/SSL, the client needs to be configured with
    // a certificate file of the server.
    secureSocket = {
        cert: "../resource/path/to/public.crt"
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
