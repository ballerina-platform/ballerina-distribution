# RabbitMQ client - Consume message

The `rabbitmq:Client` allows fetching individual messages one by one from the server. A `rabbitmq:Client` is created by passing the host and port of the RabbitMQ broker. To pull messages, use the `consumePayload` or `consumeMessage` method, which requires the queue name as the argument. Messages are fetched in the FIFO order. It is possible to use automatic or manual acknowledgments similar to consumer services. Use it to pull messages one by one from a queue in the RabbitMQ server.

::: code rabbitmq_sync_consumer.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_sync_consumer.out :::

>**Tip:** You can try out the above consumer via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/).

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#Client)
- [RabbitMQ pull API - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#7-retrieving-individual-messages)
