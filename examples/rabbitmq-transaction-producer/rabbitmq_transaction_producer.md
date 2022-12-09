# RabbitMQ client - Transactional producer

Transactions in RabbitMQ concern only messages. So, it works only when a message is published or acknowledged. In this example, the messages are sent to an existing queue using the Ballerina RabbitMQ client. A `rabbitmq:Client` can be created with the default host and port or with custom configurations. To convert the client to a transactional publisher, the message publishing should take place inside a Ballerina transaction block. Upon successful execution of the transaction block, the client will commit or roll back in the case of any error.

::: code rabbitmq_transaction_producer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).
- Declare the queue as given in the [RabbitMQ client - Declare queue](/learn/by-example/rabbitmq-queue-declare/) example.
- Run the RabbitMQ service given in the [RabbitMQ service - Transactional consumer](/learn/by-example/rabbitmq-transaction-consumer/) example.

Run the client program by executing the following command.

::: out rabbitmq_transaction_producer.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [RabbitMQ publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#5-publishing)
