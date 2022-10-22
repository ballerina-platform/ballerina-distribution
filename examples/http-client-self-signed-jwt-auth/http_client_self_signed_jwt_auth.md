# Client - self signed JWT Auth

A client, which is secured with self-signed JWT can be used to connect to a secured service.

The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/) 
and [`http` specification](https://ballerina.io/spec/http/#9127-client---self-signed-jwt).

::: code http_client_self_signed_jwt_auth.bal :::

Run the client program by executing the following command.

::: out http_client_self_signed_jwt_auth.out :::
