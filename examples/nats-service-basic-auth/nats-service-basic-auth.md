# NATS service - Basic authentication

NATS authentication deals with allowing a NATS client to connect to the server. In this example, the underlying connection of the listener is secured with Basic Authentication. A secured NATS listener can be created by passing the URL of the NATS broker and providing the authentication details using the `nats:Credentials` record. Use it when you want to authenticate client connections using a username and password.

::: code nats-service-basic-auth.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-service-basic-auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
