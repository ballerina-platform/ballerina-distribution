# gRPC client - Bearer token authentication

A client, which is secured with Bearer token authentication can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

>**Info:** You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

   ::: code grpc_client_bearer_token_auth.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start a secured service.

   ::: out grpc_client_bearer_token_auth.out :::

## Related links
- [Bearer token authentication - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/BearerTokenConfig)
- [Bearer token authentication - specification](/spec/grpc/#5116-client---bearer-token-auth)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
