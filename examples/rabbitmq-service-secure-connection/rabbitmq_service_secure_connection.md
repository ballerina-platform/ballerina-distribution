# RabbitMQ service - SSL/TLS

The underlying connection of the consumer service is secured with TLS/SSL.

::: code rabbitmq_service_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_secure_connection.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - SSL/TLS](/learn/by-example/rabbitmq-client-secure-connection/).

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [`rabbitmq` connecting to server - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
