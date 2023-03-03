# GraphQL client - Basic authentication

The `graphql:Client` can connect to a service that is secured with basic authentication by adding the `Authorization: Basic <token>` header to each request. The username and password for basic authentication can be specified in the `auth` field of the `graphql:ClientConfiguration`. Use this to communicate with the service, which is secured with basic authentication.

::: code graphql_client_security_basic_auth.bal :::

## Prerequisites
- Run the GraphQL service given in the [Basic authentication file user store](/learn/by-example/graphql-service-basic-auth-file-user-store) example.

Run the client program by executing the following command.

::: out graphql_client_security_basic_auth.out :::

## Related links
- [`graphql:CredentialsConfig` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#CredentialsConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [GraphQL client basic authentication - Specification](/spec/graphql/#1221-basic-authentication)
