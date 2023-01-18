# NATS service - SSL/TLS

The `nats:Listener` can be configured to connect to the server via SSL/TLS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the `nats:ConnectionConfiguration`. Use this to secure the communication between the client and the server.

::: code nats_service_secure_connection.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats_service_secure_connection.out :::

## Related links
- [`nats:SecureSocket` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/SecureSocket)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
