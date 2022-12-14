# RabbitMQ client - Produce message

RabbitMQ allows sending messages to a given pre-declared queue. A RabbitMQ client is created by passing the host and port of the RabbitMQ broker. For more details on declaring the queue, see the `RabbitMQ client - Declare a queue` sample. The `publishMessage` method, which requires the queue name as the routing key and the message content is used to publish messages. Use it when you want to publish messages that can be received by one or more consumers.

::: code rabbitmq_producer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).
- Declare the queue as given in the [RabbitMQ client - Declare queue](/learn/by-example/rabbitmq-queue-declare/) example.
- Run the RabbitMQ service given in the [RabbitMQ service - Consume message](/learn/by-example/rabbitmq-consumer/) example.

Run the client program by executing the following command.

::: out rabbitmq_producer.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [RabbitMQ publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#5-publishing)
