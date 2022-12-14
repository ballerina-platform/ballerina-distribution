# RabbitMQ client - SSL/TLS

The RabbitMQ broker can be configured to use SSL/TLS for secure traffic encryption. In this example, the underlying connection of the client is secured with TLS/SSL. A secured RabbitMQ client is created by passing the host and port of the broker and providing the TLS/SSL details using the `rabbitmq:SecureSocket` record. Use it to connect to a RabbitMQ server, which has SSL/TLS enabled.

::: code rabbitmq_client_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_client_secure_connection.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out rabbitmq_client_secure_connection.client.out :::

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
