# Client - self signed JWT Auth

A client, which is secured with self-signed JWT can be used to connect to a secured service.

The client is enriched with the `Authorization: Bearer <token>` header by passing the `websocket:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/).

>**Tip:** You may need to change the trusted certificate file path and private key file path in the code below.

::: code websocket_client_self_signed_jwt_auth.bal :::

Run the client program by executing the command below.

>**Tip:** As a prerequisite to running the client, start a sample service secured with JWT Auth.

::: out websocket_client_self_signed_jwt_auth.out :::