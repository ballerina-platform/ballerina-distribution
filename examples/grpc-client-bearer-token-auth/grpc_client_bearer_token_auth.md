# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to
a secured service.<br/>
The client metadata is enriched with the `Authorization: Bearer <token>`
header by passing the `grpc:BearerTokenConfig` for the `auth` configuration
of the client.

::: code grpc_client.proto :::

::: out grpc_client.out :::

::: code grpc_client_bearer_token_auth.bal :::

::: out grpc_client_bearer_token_auth.out :::