# RabbitMQ service - SSL/TLS

The RabbitMQ broker can be configured to use SSL/TLS for secure traffic encryption. In this example, the underlying connection of the listener is secured with TLS/SSL. A secured RabbitMQ listener is created by passing the host and port of the broker and providing the TLS/SSL details using the `rabbitmq:SecureSocket` record. Use it to connect to a RabbitMQ server, which has SSL/TLS enabled.

::: code rabbitmq_service_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_secure_connection.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - SSL/TLS](/learn/by-example/rabbitmq-client-secure-connection/).

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
