# RabbitMQ client - Produce message

In this example, the producer is sending a single message to the pre-declared queue, MyQueue. See `RabbitMQ client - Declare a queue` sample for more details on declaring the queue.

::: code rabbitmq_producer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).
- Declare the queue as given in the [RabbitMQ client - Declare queue](/learn/by-example/rabbitmq-queue-declare/) example.
- Run the RabbitMQ service given in the [RabbitMQ service - Consume message](/learn/by-example/rabbitmq-consumer/) example.

Run the client program by executing the following command.

::: out rabbitmq_producer.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [`rabbitmq` publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#5-publishing)
