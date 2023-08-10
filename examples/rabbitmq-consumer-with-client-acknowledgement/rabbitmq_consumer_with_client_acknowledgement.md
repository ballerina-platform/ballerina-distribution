# RabbitMQ service - Consumer with acknowledgement

The `rabbitmq:Caller` allows manual acknowledgments for the consumed messages. A `rabbitmq:Listener` is created by passing the host and port of the RabbiMQ broker. A `rabbitmq:Service` attached to the `rabbitmq:Listener` can be used to listen to a specific subject and consume incoming messages. To enable manual acknowledgments, set the `autoAck` mode in `rabbitmq:ServiceConfig` to `false`. The `rabbitmq:Caller` can be used to acknowledge the message positively or negatively using the `basicAck` and `basicNack` functions. Use it to manually acknowledge the consumed messages.

::: code rabbitmq_consumer_with_client_acknowledgement.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_consumer_with_client_acknowledgement.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Caller` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#Caller)
- [RabbitMQ client acknowledgements - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
