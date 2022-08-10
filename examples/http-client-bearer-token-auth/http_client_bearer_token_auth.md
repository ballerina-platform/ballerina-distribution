# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to
a secured service.<br/>
The client is enriched with the `Authorization: Bearer <token>` header by
passing the `http:BearerTokenConfig` for the `auth` configuration of the
client.

::: code http_client_bearer_token_auth.bal :::

::: out http_client_bearer_token_auth.out :::