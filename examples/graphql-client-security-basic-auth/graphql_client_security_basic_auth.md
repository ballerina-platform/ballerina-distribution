# GraphQL client - Basic authentication

A GraphQL client, which is secured with basic authentication can be used to connect to a secured GraphQL service. The client is enriched with the `Authorization: Basic <token>` header by passing the `graphql:CredentialsConfig` for the `auth` configuration of the client.

This example shows how to send a GraphQL request with Basic Authentication.

::: code graphql_client_security_basic_auth.bal :::

## Prerequisites
- Run the GraphQL service given in the [Basic authentication file user store](/learn/by-example/graphql-service-basic-auth-file-user-store) example.

Run the client program by executing the following command.

::: out graphql_client_security_basic_auth.out :::

## Related links
- [`graphql:CredentialsConfig` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/CredentialsConfig)
- [`auth` package API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [GraphQL client basic authentication - Specification](/spec/graphql/#1121-basic-authentication)
