# HTTP client - OAuth2 password grant type

A client, which is secured with OAuth2 password grant type can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.

::: code http_client_oauth2_password_grant_type.bal :::

## Prerequisites
- Start the [OAuth2 service](/learn/by-example/http-service-oauth2/).

Run the client program by executing the command below.

::: out http_client_oauth2_password_grant_type.out :::

## Related links
- [`http:OAuth2PasswordGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2PasswordGrantConfig)
- [`oauth2` package API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
