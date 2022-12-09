# RabbitMQ service - SSL/TLS

The RabbitMQ broker can be configured to use SSL for secure traffic encryption and as a secure alternative to basic username/password for client authentication. In this example, the underlying connection of the listener is secured with TLS/SSL. A secured `rabbitmq:Listener` can be created by using the default host and port or custom configurations and providing the TLS/SSL details using the `rabbitmq:SecureSocket` record.

::: code rabbitmq_service_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_secure_connection.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - SSL/TLS](/learn/by-example/rabbitmq-client-secure-connection/).

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
