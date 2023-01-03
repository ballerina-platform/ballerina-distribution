# RabbitMQ client - Basic authentication

The RabbitMQ authentication allows securing the client communication with the server. After an application connects to RabbitMQ and before it can perform operations, it must authenticate (i.e., present and prove its identity). In this example, the underlying connection of the client is secured with Basic Authentication. A secured `rabbitmq:Client` is created by using the default host and port or custom configurations and by providing the authentication details using the `rabbitmq:Credentials` record. Use it to authenticate client connections using a username and password.

::: code rabbitmq_client_basic_auth.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_client_basic_auth.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out rabbitmq_client_basic_auth.client.out :::

## Related links
- [`rabbitmq:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
