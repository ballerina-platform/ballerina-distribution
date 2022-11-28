# HTTP client - OAuth2 client credentials grant type

A client, which is secured with OAuth2 client credentials grant type can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.

::: code http_client_oauth2_client_credentials_grant_type.bal :::

## Prerequisites
- Start the [OAuth2 service](/learn/by-example/http-service-oauth2/).

Run the client program by executing the following command.

::: out http_client_oauth2_client_credentials_grant_type.out :::

## Related links
- [`http:OAuth2ClientCredentialsGrantConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/OAuth2ClientCredentialsGrantConfig)
- [`oauth2` package API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [`OAuth2 client credentials grant type` - specification](https://ballerina.io/spec/http/#9119-client---grant-types-oauth2)
