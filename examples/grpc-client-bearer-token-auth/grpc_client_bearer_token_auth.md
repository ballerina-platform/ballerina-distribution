# gRPC client - Bearer token authentication

A client, which is secured with Bearer token authentication can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

   ::: code grpc_client_bearer_token_auth.bal :::

You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start a secured service.

Execute the command below to run the client.

   ::: out grpc_client_bearer_token_auth.out :::

## Related links
- [`grpc:BearerTokenConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig)
- [Bearer token authentication - Specification](/spec/grpc/#5116-client---bearer-token-auth)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
