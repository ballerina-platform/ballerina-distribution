# gRPC client - Bearer token authentication

The `grpc:Client` can connect to a service that is secured with bearer token authentication by enriching the client metadata with the `Authorization: Bearer <token>` header. The bearer token can be specified in the `auth` field of the client configuration.

   ::: code grpc_client_bearer_token_auth.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run a sample secured service with bearer token authentication.

Run the client by executing the command below.

   ::: out grpc_client_bearer_token_auth.out :::

## Related links
- [`grpc:BearerTokenConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig)
- [gRPC client bearer token authentication - Specification](/spec/grpc/#5116-client---bearer-token-auth)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
