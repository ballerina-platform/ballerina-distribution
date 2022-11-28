# RabbitMQ service - Consumer with acknowledgement

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. The received messages are acknowledged manually. By default, the ackMode is `rabbitmq:AUTO_ACK`, which will automatically acknowledge all messages once consumed.

::: code rabbitmq_consumer_with_client_acknowledgement.bal :::

::: out rabbitmq_consumer_with_client_acknowledgement.out :::

## Related links
- [`rabbitmq:Caller` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Caller)
- [`rabbitmq:Caller` - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
