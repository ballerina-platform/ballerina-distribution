# RabbitMQ service - SSL/TLS

The `rabbitmq:Listener` can be configured to communicate through HTTPS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the connection configuration. Use this to secure the communication between the client and the server.

::: code rabbitmq_service_secure_connection.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_secure_connection.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - SSL/TLS](/learn/by-example/rabbitmq-client-secure-connection/).

## Related links
- [`rabbitmq:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/SecureSocket)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
