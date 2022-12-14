# NATS client - SSL/TLS

The NATS client connections can be secured by encrypting with TLS. In this example, the underlying connection of the listener is secured with basic authentication.
In this example, the underlying connection of the publisher is secured with TLS/SSL. 

::: code nats-client-secure-connection.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the client program by executing the following command.

::: out nats_client_secure_connection.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_client_secure_connection.client.out :::

## Related links
- [`nats:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
- [NATS connection- Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
