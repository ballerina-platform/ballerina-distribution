# RabbitMQ client - SSL/TLS

The `rabbitmq:Client` can be configured to connect to the server via SSL/TLS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the `rabbitmq:ConnectionConfiguration`. Use this to secure the communication between the client and the server.

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
