# HTTP client - OAuth2 password grant type

The `http:Client` can connect to a service that is secured with the OAuth2 password grant type by adding the `Authorization: Bearer <token>` header to each request. The required configurations for this grant type can be specified in the `auth` field of the client configuration. Use this grant type when you need to exchange the user's credentials for an access token.

::: code http_client_oauth2_password_grant_type.bal :::

## Prerequisites
- Run the HTTP service given in the [OAuth2 service](/learn/by-example/http-service-oauth2/) example.

Run the client program by executing the command below.

::: out http_client_oauth2_password_grant_type.out :::

## Related links
- [`http:OAuth2PasswordGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest#OAuth2PasswordGrantConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP client grant types - Specification](/spec/http/#9129-client---grant-types-oauth2)
