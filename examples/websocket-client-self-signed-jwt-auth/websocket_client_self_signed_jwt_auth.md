# Client - self signed JWT Auth

A client, which is secured with self-signed JWT can be used to connect to
a secured service.<br/>
The client is enriched with the `Authorization: Bearer <token>` header by
passing the `websocket:JwtIssuerConfig` to the `auth` configuration of the
client. A self-signed JWT is issued before the request is sent.<br/><br/>
For more information on the underlying module,
see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

::: code websocket_client_self_signed_jwt_auth.bal :::

::: out websocket_client_self_signed_jwt_auth.out :::