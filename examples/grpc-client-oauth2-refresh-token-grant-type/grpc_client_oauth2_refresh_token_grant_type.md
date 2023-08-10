# gRPC client - OAuth2 refresh token grant type 

The `grpc:Client` can connect to a service that is secured with the OAuth2 refresh token grant type by enriching the client metadata with the `Authorization: Bearer <token>` header. The required configurations for this grant type can be specified in the `auth` field of the client configuration. Use this to retrieve an access token automatically when it is expired.

   ::: code grpc_client_oauth2_refresh_token_grant_type.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - OAuth2](/learn/by-example/grpc-service-oauth2/) example.

Run the client by executing the command below.

   ::: out grpc_client_oauth2_refresh_token_grant_type.out :::

## Related links
- [`grpc:OAuth2RefreshTokenGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest#OAuth2RefreshTokenGrantConfig)
- [gRPC client OAuth2 authentication and authorization - Specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
