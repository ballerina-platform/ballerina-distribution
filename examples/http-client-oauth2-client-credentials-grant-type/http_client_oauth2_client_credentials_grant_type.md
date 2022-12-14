# HTTP client - OAuth2 client credentials grant type

The `http:Client` can be secured with OAuth2 client credentials grant type authorization by enriching each request from the client with the `Authorization: Bearer <token>` header. The required configurations for this grant type can be specified in the `auth` field of the client configuration. Use this grant type when the client needs to access resources or services on behalf of itself rather than the user.

::: code http_client_oauth2_client_credentials_grant_type.bal :::

## Prerequisites
- Run the HTTP service given in the [OAuth2 service](/learn/by-example/http-service-oauth2/) example.

Run the client program by executing the following command.

::: out http_client_oauth2_client_credentials_grant_type.out :::

## Related links
- [`http:OAuth2ClientCredentialsGrantConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2ClientCredentialsGrantConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP client OAuth2 client credentials grant type - Specification](/spec/http/#9119-client---grant-types-oauth2)
