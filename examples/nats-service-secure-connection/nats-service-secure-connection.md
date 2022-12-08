# NATS service - SSL/TLS

The NATS server uses TLS semantics to encrypt client, route, and monitoring connections. TLS can be used to encrypt traffic between client/server and check the server’s identity. Additionally - in the most secure version of TLS with NATS, the server can be configured to verify the client's identity, thus authenticating it. In this example, the underlying connection of the listener is secured with TLS/SSL. A secured `nats:Listener` can be created by using the default URL or custom configurations and providing the TLS/SSL details using the `nats:SecureSocket` record.

::: code nats-service-secure-connection.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-service-secure-connection.out :::

## Related links
- [`nats:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
