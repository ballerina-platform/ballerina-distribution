# RabbitMQ service - Consume message

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. Multiple services consuming messages from the same queue or from different queues can be attached to the same Listener.

::: code rabbitmq_consumer.bal :::

To run the sample, start an instance of the RabbitMQ server and execute the following command.

::: out rabbitmq_consumer.out :::

## Related links
- [`rabbitmq` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [`rabbitmq:Listener` - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#6-subscribing)
