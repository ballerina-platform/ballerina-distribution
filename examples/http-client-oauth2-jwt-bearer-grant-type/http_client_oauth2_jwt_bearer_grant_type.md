# HTTP client - OAuth2 JWT bearer grant type

The `http:Client` can be secured with OAuth2 JWT bearer grant type authorization. This is achieved by enriching each request from the client with the `Authorization: Bearer <token>` header. The required configurations for the OAuth2 JWT bearer grant type can be specified in the `auth` field as the `http:OAuth2JwtBearerGrantConfig` record. Use this grant type when the client wants to receive access tokens without transmitting sensitive information such as the client secret.

::: code http_client_oauth2_jwt_bearer_grant_type.bal :::

## Prerequisites
- Run the HTTP service given in the [OAuth2 service](/learn/by-example/http-service-oauth2/) example.

Run the client program by executing the command below.

::: out http_client_oauth2_jwt_bearer_grant_type.out :::

## Related links
- [`http:OAuth2JwtBearerGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2JwtBearerGrantConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP client grant types - Specification](/spec/http/#9129-client---grant-types-oauth2)
