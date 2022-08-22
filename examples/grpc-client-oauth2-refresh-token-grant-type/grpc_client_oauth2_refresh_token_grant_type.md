# Client - OAuth2 Refresh Token grant type

A client, which is secured with an OAuth2 refresh token grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2RefreshTokenGrantConfig` to the `auth` configuration of the client.

For more information on the underlying module, see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

4. Run the client using the command below.

   ::: out grpc_client_oauth2_refresh_token_grant_type.out :::

As a prerequisite, start a sample service secured with OAuth2.

You may need to change the trusted certificate file path.
