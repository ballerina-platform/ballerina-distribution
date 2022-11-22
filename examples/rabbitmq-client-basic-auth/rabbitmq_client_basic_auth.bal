import ballerinax/rabbitmq;

public function main() returns error? {
    // Creates a ballerina RabbitMQ client with username/password authentication.
    rabbitmq:Client rabbitmqClient = check new(rabbitmq:DEFAULT_HOST, 5672,
        // To secure the client connections using username/password authentication, provide the credentials
        // with the `rabbitmq:Credentials` record.
        auth = {
             username: "alice",
             password: "alice@123"
        }
    );
}
