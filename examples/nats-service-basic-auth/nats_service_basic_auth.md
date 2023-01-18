# NATS service - Basic authentication

The NATS authentication allows securing the client communication with the server. In this example, the underlying connection of the listener is secured with Basic Authentication. A secured `nats:Listener` can be created by passing the URL of the NATS broker and providing the authentication details using the `nats:Credentials` record. Use it to authenticate client connections using a username and password.

::: code nats_service_basic_auth.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats_service_basic_auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
