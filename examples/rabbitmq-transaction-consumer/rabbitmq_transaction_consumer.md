# RabbitMQ service - Transactional consumer

The RabbitMQ service can become a transactional consumer by acknowledging messages within a Ballerina transaction block. A RabbitMQ listener can be created by passing the host and port of the RabbitMQ broker. A RabbitMQ service attached to the listener can be used to listen to a specific queue. The queue to listen to should be given as the service name or in the `queueName` field of the `rabbitmq:ServiceConfig`. The `rabbitmq:Caller`, which is passed as an argument in the `onMessage` remote method is used to acknowledge the message inside a transaction block. Use it to consume messages with ensured acknowledgment to the RabbitMQ server.

::: code rabbitmq_transaction_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_transaction_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Transactional producer](/learn/by-example/rabbitmq-transaction-producer//).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [RabbitMQ client acknowledgments - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
