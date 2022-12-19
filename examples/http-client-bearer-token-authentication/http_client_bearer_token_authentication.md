# HTTP client - Bearer token authentication

The `http:Client` can connect to a service that is secured with bearer token authentication by adding the `Authorization: Bearer <token>` header to each request. The bearer token can be specified in the `auth` field of the client configuration.

::: code http_client_bearer_token_authentication.bal :::

## Prerequisites
- Run a sample secured service with bearer token authentication.

Run the client program by executing the command below.

::: out http_client_bearer_token_authentication.out :::

## Related links
- [`http:BearerTokenConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/BearerTokenConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP client bearer token authentication - Specification](/spec/http/#9116-client---bearer-token-auth)
