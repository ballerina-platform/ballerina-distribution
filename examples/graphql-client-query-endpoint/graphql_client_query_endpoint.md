# GraphQL client - Query GraphQL endpoint

The GraphQL Client can be used to connect and interact with a GraphQL server. It can be used to do `Query` and `Mutation` operations on a GraphQL service.

This example shows how to send a GraphQL request and retrieve the response in a user-defined type.

::: code graphql_client_query_endpoint.bal :::

Further, the execute method optionally takes a map of variables and an operationName in case the document contains any variables or contains more than one operation. For more information on the underlying package, see the [`graphql` package](https://lib.ballerina.io/ballerina/graphql/latest/).

>**Tip:** As a prerequisite to run the client program, execute a ballerina GraphQL server program given in [Returning record values example](https://ballerina.io/learn/by-example/graphql-returning-record-values).

Run the client program by executing the following command.

::: out graphql_client_query_endpoint.out :::

## Related links
- [`graphql:Client` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/clients/Client)
- [`graphql:Client` - Specification](/spec/graphql/#25-client)
