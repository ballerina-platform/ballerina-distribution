# RabbitMQ service - Consumer with acknowledgement

In this example, a RabbitMQ service is consuming messages from the pre-declared queue (i.e., `OrderQueue`). A `rabbitmq:Listener` can be created with the default host and port or with custom configurations. A `rabbitmq:Service` attached to the `rabbitmq:Listener` can be used to listen to a specific subject and consume incoming messages. The queue to listen to should be given as the service name or in the `queueName` field of the `rabbitmq:ServiceConfig`. The received messages are acknowledged manually. By default, the `autoAck ` mode is enabled, which will automatically acknowledge all messages once consumed. To enable manual acknowlegments, set the `autoAck` mode in `rabbitmq:ServiceConfig` to `false`. The `rabbitmq:Caller` can be used to acknowledge the message positively or negatively using the `basicAck` and `basicNack` functions.

::: code rabbitmq_consumer_with_client_acknowledgement.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_consumer_with_client_acknowledgement.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Caller` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Caller)
- [RabbitMQ client acknowledgements - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
