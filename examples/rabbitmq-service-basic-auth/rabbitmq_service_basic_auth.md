# RabbitMQ service - Basic authentication

The RabbitMQ authentication allows securing the client communication with the server. After an application connects to RabbitMQ and before it can perform operations, it must authenticate (i.e., present and prove its identity). In this example, the underlying connection of the listener is secured with Basic Authentication. A secured `rabbitmq:Listener` is created by using the default host and port or custom configurations and by providing the authentication details using the `rabbitmq:Credentials` record. Use it to authenticate client connections using a username and password.

::: code rabbitmq_service_basic_auth.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_basic_auth.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Basic authentication](/learn/by-example/rabbitmq-client-basic-auth/).

## Related links
- [`rabbitmq:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#Credentials)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
