# RabbitMQ service - Consume message

The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. Multiple services consuming messages from the same queue or from different queues can be attached to the same Listener.

::: code rabbitmq_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html). 

Run the service by executing the following command.

::: out rabbitmq_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [RabbitMQ subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#6-subscribing)
