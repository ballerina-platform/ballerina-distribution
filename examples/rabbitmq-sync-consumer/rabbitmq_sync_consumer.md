# RabbitMQ client - Consume message

In this example, the RabbitMQ client is used to consume a message from a pre-declared queue. 

::: code rabbitmq_sync_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_sync_consumer.out :::

>**Tip:** You can try out the above consumer via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [RabbitMQ pull API - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#7-retrieving-individual-messages)
