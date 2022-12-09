# RabbitMQ service - Consume message

In the messaging model of RabbitMQ, the producer sends messages, a queue is a buffer that stores messages and the consumer receives messages. The messages are consumed from an existing queue using the Ballerina RabbitMQ message listener. Multiple services consuming messages from the same queue or different queues can be attached to the same Listener. In this example, a RabbitMQ service is consuming messages from the pre-declared queue, OrderQueue. A `rabbitmq:Listener` can be created with the default host and port or with custom configurations. A `rabbitmq:Service` attached to the `rabbitmq:Listener` can be used to listen to a specific queue and consume incoming messages. The queue to listen to should be given as the service name or in the `queueName` field of the `rabbitmq:ServiceConfig`

::: code rabbitmq_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html). 

Run the service by executing the following command.

::: out rabbitmq_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [RabbitMQ subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#6-subscribing)
