import ballerina/http;
import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

service / on new http:Listener(9092) {
    private final rabbitmq:Client orderClient;

    function init() returns error? {
        // Initiate the RabbitMQ client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.orderClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT,
            // To secure the client connections using username/password authentication, provide the credentials
            // with the `rabbitmq:Credentials` record.
            auth = {
                 username: "alice",
                 password: "alice@123"
            }
        );
    }

    resource function post orders(@http:Payload Order newOrder) returns http:Accepted|error {
        // Publishes the message using newClient and the routing key named OrderQueue.
        check self.orderClient->publishMessage({
            content: newOrder,
            routingKey: "OrderQueue"
        });

        return http:ACCEPTED;
    }
}
