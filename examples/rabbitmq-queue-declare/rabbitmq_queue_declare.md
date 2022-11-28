# RabbitMQ client - Declare queue

In this example, the RabbitMQ client is declaring a queue. Queues in RabbitMQ are ordered collections of messages. Messages are enqueued and dequeued in the FIFO manner.

::: code rabbitmq_queue_declare.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_queue_declare.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [`rabbitmq` exchanges and queues - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#3-exchanges-and-queues)
