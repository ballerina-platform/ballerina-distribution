# RabbitMQ service - Basic authentication

RabbitMQ connection to the server has an associated user which is authenticated. It also targets a virtual host for which the user must have a certain set of permissions. After an application connects to RabbitMQ and before it can perform operations, it must authenticate, that is, present and prove its identity. One of the primary ways of authenticating a client is by providing username/password credentials. In this example, the underlying connection of the listener is secured with basic authentication. A secured `rabbitmq:Listener` can be created by using the default host and port or custom configurations and providing the authentication details using the `rabbitmq:Credentials` record.

::: code rabbitmq_service_basic_auth.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_basic_auth.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Basic authentication](/learn/by-example/rabbitmq-client-basic-auth/).

## Related links
- [`rabbitmq:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
