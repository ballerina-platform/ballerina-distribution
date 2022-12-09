# RabbitMQ client - Produce message

In the messaging model of RabbitMQ, the producer sends messages, a queue is a buffer that stores messages and the consumer receives messages. In this example, the producer is sending a single message to the pre-declared queue, OrderQueue. See `RabbitMQ client - Declare a queue` sample for more details on declaring the queue. A `rabbitmq:Client` can be created with the default host and port or with custom configurations. The `publishMessage` function can be used to send messages to the RabbiTMQ server by providing the queue as the routing key and the message content. The messages sent are received by any active subscriber listening on that queue.

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
