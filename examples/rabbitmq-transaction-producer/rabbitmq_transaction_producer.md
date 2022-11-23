# RabbitMQ client - Transactional producer

A message is sent to an existing queue using the Ballerina RabbitMQ channel and Ballerina transactions. Upon successful execution of the transaction block, the channel will commit and rollback in the case of any error.

::: code rabbitmq_transaction_producer.bal :::

::: out rabbitmq_transaction_producer.out :::

## Related links
- [`rabbitmq:Client` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [`rabbitmq:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#5-publishing)
