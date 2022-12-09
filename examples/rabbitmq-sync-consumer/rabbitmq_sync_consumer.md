# RabbitMQ client - Consume message

In the messaging model of RabbitMQ, the producer sends messages, a queue is a buffer that stores messages and the consumer receives messages. In this example, the messages from the pre-declared queue OrderQueue are consumed using a Ballerina RabbitMQ client. A `rabbitmq:Client` can be created with the default host and port or with custom configurations. With the client, it is possible to fetch messages one by one using the functions `consumePayload` or `consumeMessage`. Messages are fetched in the FIFO order. It is possible to use automatic or manual acknowledgments, just like with consumer services.

::: code rabbitmq_sync_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_sync_consumer.out :::

>**Tip:** You can try out the above consumer via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [RabbitMQ pull API - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#7-retrieving-individual-messages)
