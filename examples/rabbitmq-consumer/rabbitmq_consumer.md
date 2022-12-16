# RabbitMQ service - Consume message

The RabbitMQ service listens to the given queue for incoming messages. When a publisher sends a message on a queue, any active service listening on that queue receives the message. A RabbitMQ listener is created by passing the host and port of the RabbiMQ broker. A `rabbitmq:Service` attached to the listener is used to listen to a specific queue and consume incoming messages. The queue to listen to should be given as the service name or in the `queueName` field of the `rabbitmq:ServiceConfig`. Use it to listen to messages sent to a particular queue.

::: code rabbitmq_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html). 

Run the service by executing the following command.

::: out rabbitmq_consumer.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [RabbitMQ subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#6-subscribing)
