# Client - self signed JWT Auth

A client, which is secured with self-signed JWT can be used to connect to
a secured service.<br/>
The client metadata is enriched with the `Authorization: Bearer <token>`
header by passing the `http:JwtIssuerConfig` to the `auth` configuration
of the client. A self-signed JWT is issued before the request is sent.<br/><br/>
For more information on the underlying module,
see the [OAuth2 module](https://docs.central.ballerina.io/ballerina/oauth2/latest/).

::: code grpc_client.proto :::

::: out grpc_client.out :::

::: code grpc_client_self_signed_jwt_auth.bal :::

::: out grpc_client_self_signed_jwt_auth.out :::