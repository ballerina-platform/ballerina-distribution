# GraphQL client - Query GraphQL endpoint

The GraphQL client can be used to connect and interact with a GraphQL server.  A GraphQL client is created by passing the URL of a GraphQL service endpoint. To execute a GraphQL operation the `execute` method is used. This method requires the GraphQL `document` as a required argument and optionally takes a map of `variables` and an `operationName` as arguments in case the document contains any variables or contains more than one operation. Use the GraphQL client when you want to execute `Query` and `Mutation` operations on a GraphQL service.

This example shows how to send a GraphQL request and retrieve the response in a user-defined type.

::: code graphql_client_query_endpoint.bal :::

## Prerequisites
- Run the GraphQL service given in the [Record as output object](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_query_endpoint.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/clients/Client)
- [GraphQL client - Specification](/spec/graphql/#25-client)
