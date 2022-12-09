# RabbitMQ client - SSL/TLS

The RabbitMQ broker can be configured to use SSL for secure traffic encryption and as a secure alternative to basic username/password for client authentication. In this example, the underlying connection of the client is secured with TLS/SSL. A secured `rabbitmq:Client` can be created by using the default host and port or custom configurations and providing the TLS/SSL details using the `rabbitmq:SecureSocket` record.

::: code rabbitmq_client_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_client_secure_connection.out :::

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
