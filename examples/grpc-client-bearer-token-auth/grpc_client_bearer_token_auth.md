# gRPC client - Bearer token authentication

A client, which is secured with Bearer token authentication can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

   ::: code grpc_client_bearer_token_auth.bal :::

You can refer to the [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/) to implement the client used here.

## Prerequisites
- Start a secured service.

Run the client by executing the command below.

   ::: out grpc_client_bearer_token_auth.out :::

## Related links
- [`grpc:BearerTokenConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig)
- [gRPC client bearer token authentication - Specification](/spec/grpc/#5116-client---bearer-token-auth)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
