import ballerina/io;
import ballerinax/rabbitmq;

public function main() {
    // Creates a Ballerina RabbitMQ connection that allows re-usability if necessary.
    rabbitmq:Connection connection = new ({host: "localhost", port: 5672});

    // Creates a Ballerina RabbitMQ channel.
    rabbitmq:Channel newChannel = new (connection);

    // Declares a queue named `MyQueue`.
    string|rabbitmq:Error? queueResult =
            newChannel->queueDeclare({queueName: "MyQueue"});
    if (queueResult is error) {
        io:println("An error occurred while creating the queue.");
    }

    // Declares a direct exchange named `MyExchange`.
    rabbitmq:Error? exchangeResult =
            newChannel->exchangeDeclare({exchangeName: "MyExchange",
                                      exchangeType: rabbitmq:DIRECT_EXCHANGE });
    if (exchangeResult is error) {
        io:println("An error occurred while creating the exchange.");
    }

    // Binds `MyQueue` to `MyExchange` with the routing key named `example-key`.
    rabbitmq:Error? bindResult =
            newChannel->queueBind("MyQueue", "MyExchange", "example-key");

    // Publishes the message to the `example-key` using the `newChannel`.
    rabbitmq:Error? sendResult = newChannel->basicPublish("Hello from Ballerina",
                                      "example-key", "MyExchange");
    if (sendResult is error) {
        io:println("An error occurred while sending the message to " +
                    "example-key using newChannel.");
    }
}
