# NATS service - SSL/TLS

The NATS server uses TLS to encrypt the communication between the client and the server. TLS can be used to encrypt traffic between the client/server and check the server’s identity. In this example, the underlying connection of the listener is secured with TLS/SSL. A secured NATS listener is created by passing the URL of the NATS broker and providing the TLS/SSL details using the `nats:SecureSocket` record. Use it to connect to a NATS server, which has SSL/TLS enabled.

::: code nats-service-secure-connection.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-service-secure-connection.out :::

## Related links
- [`nats:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
