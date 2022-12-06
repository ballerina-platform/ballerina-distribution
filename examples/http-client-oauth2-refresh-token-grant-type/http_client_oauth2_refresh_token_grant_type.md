# HTTP client - OAuth2 refresh token grant type

A client, which is secured with an OAuth2 refresh token grant type can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:OAuth2RefreshTokenGrantConfig` to the `auth` configuration of the client.

::: code http_client_oauth2_refresh_token_grant_type.bal :::

## Prerequisites
- Run the HTTP service given in the [OAuth2 service](/learn/by-example/http-service-oauth2/) example.

Run the client program by executing the command below.

::: out http_client_oauth2_refresh_token_grant_type.out :::

## Related links
- [`http:OAuth2RefreshTokenGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2RefreshTokenGrantConfig)
- [`oauth2` package API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP client grant types - Specification](/spec/http/#9129-client---grant-types-oauth2)
