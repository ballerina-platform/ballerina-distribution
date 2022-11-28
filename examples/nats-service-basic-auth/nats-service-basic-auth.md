# NATS service - Basic authentication

NATS client connections can be authenticated in many ways. One of them is by using the username and password credentials. In this example, the underlying connection of the listener is secured with basic authentication.

::: code nats-service-basic-auth.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-service-basic-auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [`nats` connecting to server - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
