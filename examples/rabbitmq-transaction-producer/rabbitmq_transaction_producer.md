# RabbitMQ client - Transactional producer

The `rabbitmq:Client` can become a transactional producer by publishing messages within a Ballerina transaction block. Upon successful execution of the transaction block, the client will commit or roll back in the case of any error. A `rabbitmq:Client` can be created by passing the host and port of the RabbitMQ broker. To publish messages, the `publishMessage` method, which requires the message and queue name as arguments is used. Use it to publish messages to the RabbitMQ server with ensured delivery.

::: code rabbitmq_transaction_producer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).
- Declare the queue as given in the [RabbitMQ client - Declare queue](/learn/by-example/rabbitmq-queue-declare/) example.
- Run the RabbitMQ service given in the [RabbitMQ service - Transactional consumer](/learn/by-example/rabbitmq-transaction-consumer/) example.

Run the client program by executing the following command.

::: out rabbitmq_transaction_producer.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#Client)
- [RabbitMQ publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#5-publishing)
