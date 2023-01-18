# HTTP client - Self signed JWT authentication

The `http:Client` can connect to a service that is secured with self-signed JWT by adding the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

::: code http_client_self_signed_jwt_authentication.bal :::

## Prerequisites
- Run the HTTP service given in the [JWT Auth service](/learn/by-example/http-service-jwt-authentication/) example.

Run the client program by executing the command below.

::: out http_client_self_signed_jwt_authentication.out :::

## Related links
- [`http:JwtIssuerConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/JwtIssuerConfig)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
- [HTTP client self signed JWT authentication - Specification](/spec/http/#9127-client---self-signed-jwt)
