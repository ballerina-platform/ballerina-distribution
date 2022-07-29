# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to a secured service.
The client is enriched with the `Authorization: Basic <token>` header by passing the 
`websocket:CredentialsConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [Auth module](https://docs.central.ballerina.io/ballerina/auth/latest/).

::: code websocket_client_basic_auth.bal :::

::: out websocket_client_basic_auth.out :::