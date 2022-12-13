# NATS client - Basic authentication

NATS client connections can be authenticated in many ways. One of them is by using the username and password credentials. In this example, the underlying connection of the publisher is secured with basic authentication. 

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
