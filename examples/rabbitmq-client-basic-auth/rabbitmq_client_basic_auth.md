# RabbitMQ client - Basic authentication

The underlying connection of the producer is secured with basic authentication.

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
