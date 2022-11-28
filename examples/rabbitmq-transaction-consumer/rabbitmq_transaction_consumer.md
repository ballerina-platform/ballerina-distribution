# RabbitMQ service - Transactional consumer

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener and Ballerina transactions. Upon successful execution of the transaction block, the acknowledgement will commit or rollback in the case of any error. Messages will not be re-queued in the case of a rollback automatically unless negatively acknowledged by the user.

::: code rabbitmq_transaction_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_transaction_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Transactional producer](/learn/by-example/rabbitmq-transaction-producer//).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [`rabbitmq` acknowledgements - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
