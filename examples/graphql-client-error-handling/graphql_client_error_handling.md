# GraphQL client - Handle error response

The `graphql:Client` allows handling different errors occurred when executing the `execute` method. It returns a `graphql:ClientError` error, which has different subtypes that can be handled differently based on the use case. Use the subtypes of the `graphql:ClientError` to handle different types of errors based on the use case.

::: code graphql_client_error_handling.bal :::

## Prerequisites
- Run the GraphQL service given in the [Mutations](https://ballerina.io/learn/by-example/graphql-mutations/) example.

Run the client program by executing the following command.

::: out graphql_client_error_handling.out :::

## Related links
- [`graphql:ClientError` error - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/errors#ClientError)
- [GraphQL client error handling - Specification](/spec/graphql/#255-client-error-handling)
