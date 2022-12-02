# GraphQL client - Query GraphQL endpoint

The GraphQL Client can be used to connect and interact with a GraphQL server. It can be used to do `Query` and `Mutation` operations on a GraphQL service.

This example shows how to send a GraphQL request and retrieve the response in a user-defined type.

::: code graphql_client_query_endpoint.bal :::

Further, the execute method optionally takes a map of variables and an operationName in case the document contains any variables or contains more than one operation.

## Prerequisites
- Run the GraphQL service given in the [Record as output object](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_query_endpoint.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/clients/Client)
- [GrapHQL client - Specification](/spec/graphql/#25-client)
