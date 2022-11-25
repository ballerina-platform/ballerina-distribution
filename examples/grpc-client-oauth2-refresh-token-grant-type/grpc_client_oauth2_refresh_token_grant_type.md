# gRPC client - OAuth2 refresh token grant type 

A client, which is secured with an OAuth2 refresh token grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2RefreshTokenGrantConfig` to the `auth` configuration of the client.

   ::: code grpc_client_oauth2_refresh_token_grant_type.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start the [OAuth2 service](/learn/by-example/grpc-service-oauth2/).

Execute the command below to run the client.

   ::: out grpc_client_oauth2_refresh_token_grant_type.out :::

## Related links
- [`grpc:OAuth2RefreshTokenGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2RefreshTokenGrantConfig)
- [OAuth2 authentication and authorization - specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` package - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
