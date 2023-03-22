# GraphQL client - Query GraphQL endpoint

The `graphql:Client` allows connecting and interacting with a GraphQL server.  A `graphql:Client` is created by passing the URL of a GraphQL service endpoint. The `execute` method is used to execute a GraphQL operation. This method requires the GraphQL `document` as a required argument and takes a map of `variables` and an `operationName` as arguments optionally, in case the document contains any variables or contains more than one operation. Use the GraphQL client to execute the `Query` and `Mutation` operations on a GraphQL service.

::: code graphql_client_query_endpoint.bal :::

## Prerequisites
- Run the GraphQL service given in the [Record as output object](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_query_endpoint.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Client)
- [GraphQL client - Specification](/spec/graphql/#25-client)
