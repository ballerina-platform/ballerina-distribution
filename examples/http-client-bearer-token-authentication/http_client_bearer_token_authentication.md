# HTTP client - Bearer token authentication

A client, which is secured with Bearer token auth can be used to connect to a secured service. The client is enriched with the `Authorization: Bearer <token>` header by passing the `http:BearerTokenConfig` for the `auth` configuration of the client.

::: code http_client_bearer_token_authentication.bal :::

## Prerequisites
 - Run a sample secured service.

Run the client program by executing the command below.

::: out http_client_bearer_token_authentication.out :::

## Related links
- [`http:BearerTokenConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/BearerTokenConfig)
- [`auth` package API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP client bearer token authentication - Specification](/spec/http/#9116-client---bearer-token-auth)
