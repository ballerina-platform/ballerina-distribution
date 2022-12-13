# HTTP client - Bearer token authentication

An `http:Client` can be secured with bearer token authentication. This is achieved by enriching each request from the client with the `Authorization: Bearer <token>` header. The bearer token can be specified in the `auth` field of the `http:ClientConfiguration`. Use this to communicate with the service, which is secured with bearer token authentication.

::: code http_client_bearer_token_authentication.bal :::

## Prerequisites
 - Run a sample secured service with bearer token authentication.

Run the client program by executing the command below.

::: out http_client_bearer_token_authentication.out :::

## Related links
- [`http:BearerTokenConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/BearerTokenConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP client bearer token authentication - Specification](/spec/http/#9116-client---bearer-token-auth)
