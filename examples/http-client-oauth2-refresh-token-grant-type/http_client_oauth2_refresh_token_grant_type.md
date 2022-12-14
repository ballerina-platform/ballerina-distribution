# HTTP client - OAuth2 refresh token grant type

The `http:Client` can be secured with OAuth2 refresh token grant type authorization by enriching each request from the client with the `Authorization: Bearer <token>` header. The required configurations for this grant type can be specified in the `auth` field of the client configuration. Use this grant type when the client needs to exchange a refresh token for an access token if the access token has expired. This allows the client to have a valid access token without further interaction with the user.

::: code http_client_oauth2_refresh_token_grant_type.bal :::

## Prerequisites
- Run the HTTP service given in the [OAuth2 service](/learn/by-example/http-service-oauth2/) example.

Run the client program by executing the command below.

::: out http_client_oauth2_refresh_token_grant_type.out :::

## Related links
- [`http:OAuth2RefreshTokenGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2RefreshTokenGrantConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP client grant types - Specification](/spec/http/#9129-client---grant-types-oauth2)
