# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to a secured service.

The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:BearerTokenConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/)
and [`http` specification](https://ballerina.io/spec/http/#9116-client---bearer-token-auth).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code http_client_bearer_token_auth.bal :::

Run the client program by executing the command below.

>**Info:** As a prerequisite to running the client, start a secured sample service.

::: out http_client_bearer_token_auth.out :::
