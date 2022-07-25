# Transactional producer

A message is sent to an existing queue
using the Ballerina RabbitMQ channel and Ballerina transactions.
Upon successful execution of the transaction block,
the channel will commit and rollback in the case of any error.
For more information on the underlying module,
see the [RabbitMQ module](https://docs.central.ballerina.io/ballerinax/rabbitmq/latest).

::: code rabbitmq_transaction_producer.bal :::

::: out rabbitmq_transaction_producer.out :::