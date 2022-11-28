# RabbitMQ service - Consumer with acknowledgement

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. The received messages are acknowledged manually. By default, the ackMode is `rabbitmq:AUTO_ACK`, which will automatically acknowledge all messages once consumed.

::: code rabbitmq_consumer_with_client_acknowledgement.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_consumer_with_client_acknowledgement.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Caller` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Caller)
- [`rabbitmq` acknowledgements - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#8-client-acknowledgements)
