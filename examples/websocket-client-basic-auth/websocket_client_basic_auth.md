# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to
a secured service.<br/>
The client is enriched with the `Authorization: Basic <token>` header by
passing the `websocket:CredentialsConfig` for the `auth` configuration of the
client.<br/><br/>
For more information on the underlying module,
see the [Auth module](https://lib.ballerina.io/ballerina/auth/latest/).

::: code websocket_client_basic_auth.bal :::

::: out websocket_client_basic_auth.out :::