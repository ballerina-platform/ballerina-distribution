# RabbitMQ client - Basic authentication

RabbitMQ authentication deals with allowing a RabbitMQ client to connect to the server. After an application connects to RabbitMQ and before it can perform operations, it must authenticate, that is, present and prove its identity. In this example, the underlying connection of the client is secured with Basic Authentication. A secured RabbitMQ client is created by using the default host and port or custom configurations and providing the authentication details using the `rabbitmq:Credentials` record. Use it when you want to authenticate clients connections using username and password.

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
