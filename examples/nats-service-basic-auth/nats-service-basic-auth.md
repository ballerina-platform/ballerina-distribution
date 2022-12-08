# NATS service - Basic authentication

Authentication deals with allowing a NATS client to connect to the server. One of the ways to authenticate is by using the username and password credentials. You can authenticate one or more clients using username and passwords. This enables you to have greater control over the management and issuance of credential secrets. In this example, the underlying connection of the listener is secured with basic authentication. A secured `nats:Listener` can be created by using the default URL or custom configurations and providing the authentication details using the `nats:Credentials` record.

::: code nats-service-basic-auth.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-service-basic-auth.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
