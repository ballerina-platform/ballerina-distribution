# RabbitMQ client - Declare queue

In RabbitMQ, exchanges are where messages are sent to. Exchanges take a message and route it into zero or more queues. The default exchange is a direct exchange with no name (empty string) pre-declared by the broker. Every queue that is created is automatically bound to it with the routing key which is the same as the queue name. In this example a queue named OrderQueue with default configurations is created. A `rabbitmq:Client` can be created with the default host and port or with custom configurations. A queue with a specific name and custom configurations can be declared by using the function `queueDeclare`.  To create a queue with a server-generated name and custom configurations, function `queueAutoGenerate` can be used.

::: code rabbitmq_queue_declare.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_queue_declare.out :::

## Related links
- [`rabbitmq:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/clients/Client)
- [RabbitMQ exchanges and queues - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#3-exchanges-and-queues)
