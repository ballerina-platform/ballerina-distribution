# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to
a secured service.<br/>
The client metadata is enriched with the `Authorization: Bearer <token>`
header by passing the `grpc:BearerTokenConfig` for the `auth` configuration
of the client.

::: code ./examples/grpc-client-bearer-token-auth/grpc_client.proto :::

::: out ./examples/grpc-client-bearer-token-auth/grpc_client.out :::

::: code ./examples/grpc-client-bearer-token-auth/grpc_client_bearer_token_auth.bal :::

::: out ./examples/grpc-client-bearer-token-auth/grpc_client_bearer_token_auth.out :::