# gRPC client - Bearer token authentication

The `grpc:Client` can connect to a service that is secured with bearer token authentication by enriching the client metadata with the `Authorization: Bearer <token>` header. The bearer token can be specified in the `auth` field of the client configuration. Use this to communicate with the service, which is secured with bearer token authentication.

   ::: code grpc_client_bearer_token_auth.bal :::

You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run a sample secured service with bearer token authentication.

Run the client by executing the command below.

   ::: out grpc_client_bearer_token_auth.out :::

## Related links
- [`grpc:BearerTokenConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig)
- [gRPC client bearer token authentication - Specification](/spec/grpc/#5116-client---bearer-token-auth)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
