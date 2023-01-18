# HTTP client - Basic authentication

The `http:Client` can connect to a service that is secured with basic authentication by adding the `Authorization: Basic <token>` header to each request. The username and password for basic authentication can be specified in the `auth` field of the client configuration.

::: code http_client_basic_authentication.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic authentication file user store service](/learn/by-example/http-service-basic-authentication-file-user-store) example.

Run the client program by executing the command below.

::: out http_client_basic_authentication.out :::

## Related links
- [`http:CredentialsConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/CredentialsConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP client basic authentication - Specification](/spec/http/#9115-client---basic-auth)
