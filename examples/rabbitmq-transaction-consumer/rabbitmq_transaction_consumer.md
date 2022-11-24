# RabbitMQ service - Transactional consumer

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener and Ballerina transactions. Upon successful execution of the transaction block, the acknowledgement will commit or rollback in the case of any error. Messages will not be re-queued in the case of a rollback automatically unless negatively acknowledged by the user.

::: code rabbitmq_transaction_consumer.bal :::

To run the sample, start an instance of the RabbitMQ server and execute the following command.

::: out rabbitmq_transaction_consumer.out :::

## Related links
- [`rabbitmq` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [`rabbitmq:Caller` - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
