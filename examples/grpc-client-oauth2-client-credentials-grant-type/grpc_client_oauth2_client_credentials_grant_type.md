# gRPC client - OAuth2 client credentials grant type 

The `grpc:Client` can connect to a service that is secured with the OAuth2 client credentials grant type by enriching client metadata with the `Authorization: Bearer <token>` header. The required configurations for this grant type can be specified in the `auth` field of the client configuration.

   ::: code grpc_client_oauth2_client_credentials_grant_type.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run the gRPC service given in the [gRPC service - OAuth2](/learn/by-example/grpc-service-oauth2/) example.

Run the client by executing the command below.

   ::: out grpc_client_oauth2_client_credentials_grant_type.out :::

## Related links
- [`grpc:OAuth2ClientCredentialsGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/OAuth2ClientCredentialsGrantConfig)
- [gRPC client OAuth2 authentication and authorization - Specification](/spec/grpc/#5118-client---oauth2)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
