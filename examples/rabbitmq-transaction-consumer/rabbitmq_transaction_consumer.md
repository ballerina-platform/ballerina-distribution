# RabbitMQ service - Transactional consumer

Transactions in RabbitMQ concern only messages. So, it works only when a message is published or acknowledged. In this example, the messages are consumed from an existing queue using the Ballerina RabbitMQ message listener and upon receiving the message, the acknowledgment is done with Ballerina transactions. Upon successful execution of the transaction block, the acknowledgment will commit or roll back in the case of any error. Messages will not be re-queued in the case of a rollback automatically unless negatively acknowledged by the user.

::: code rabbitmq_transaction_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_transaction_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Transactional producer](/learn/by-example/rabbitmq-transaction-producer//).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [RabbitMQ client acknowledgments - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
