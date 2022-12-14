# NATS client - Basic authentication

NATS authentication deals with allowing a NATS client to connect to the server. In this example, the underlying connection of the client is secured with Basic Authentication. A secured NATS client can be created by passing the URL of the NATS broker and providing the authentication details using the `nats:Credentials` record. Use it to authenticate client connections using a username and password.

::: code nats-client-basic-auth.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the client program by executing the following command.

::: out nats_client_basic_auth.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_client_basic_auth.client.out :::

## Related links
- [`nats:Credentials` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/records/Credentials)
- [NATS connection - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#2-connection)
