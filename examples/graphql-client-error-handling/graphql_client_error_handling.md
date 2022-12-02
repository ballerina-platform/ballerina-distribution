# GraphQL client - Error handling

The execute method of `graphql:Client` can fail and return a `graphql:ClientError`. This example demonstrates `graphql:Client` error handling and shows how to obtain GraphQL-specific errors returned by the graphql server.

::: code graphql_client_error_handling.bal :::

## Prerequisites
- Run the GraphQL service given in the [Mutations](https://ballerina.io/learn/by-example/graphql-mutations/) example.

Run the client program by executing the following command.

::: out graphql_client_error_handling.out :::

## Related links
- [`graphql:ClientError` error - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/errors#ClientError)
- [GraphQL client error handling - Specification](/spec/graphql/#255-client-error-handling)
