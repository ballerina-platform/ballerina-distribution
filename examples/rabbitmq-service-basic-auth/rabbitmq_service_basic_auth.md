# RabbitMQ service - Basic authentication

The underlying connection of the consumer service is secured with basic authentication.

::: code rabbitmq_service_basic_auth.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the service by executing the following command.

::: out rabbitmq_service_basic_auth.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client - Basic authentication](/learn/by-example/rabbitmq-client-basic-auth/).

## Related links
- [`rabbitmq:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/records/Credentials)
- [RabbitMQ connection - Specification](https://github.com/ballerina-platform/module-ballerinax-rabbitmq/blob/master/docs/spec/spec.md#2-connection)
