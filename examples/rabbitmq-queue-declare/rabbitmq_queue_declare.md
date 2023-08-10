# RabbitMQ client - Declare queue

A RabbitMQ queue is a buffer that stores messages. The queue takes messages from the publisher and sends them to the consumer. A `rabbitmq:Client` is created with the host and port of the RabbitMQ broker. A queue with a specific name and custom configurations can be declared by using the `queueDeclare` method. To create a queue with a server-generated name, the `queueAutoGenerate` method can be used. Use this to declare the queue before publishing messages.

::: code rabbitmq_queue_declare.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_queue_declare.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#Client)
- [RabbitMQ exchanges and queues - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#3-exchanges-and-queues)
