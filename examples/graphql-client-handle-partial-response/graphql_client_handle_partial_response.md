# GraphQL client - Handle partial response

The `graphql:Client` allows handling cases where a GraphQL service responds with partial data along with errors. To retrieve the partial data, define the fields as nilable types in the expected response type where applicable. Use this approach when the response with partial data is considered to be valid or the partial data needs to be retrieved.

>**Hint:** When defining field types as nilable, check the corresponding GraphQL schema to check the nilable fields.

::: code graphql_client_handle_partial_response.bal :::

## Prerequisites
- Run the GraphQL service given in the [Error handling](https://ballerina.io/learn/by-example/graphql-service-error-handling) example.

Run the client program by executing the following command.

::: out graphql_client_handle_partial_response.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Client)
- [`graphql:GenericResponseWithErrors` record - API documentation](https://lib.ballerina.io/ballerina/graphql/1.4.4#GenericResponseWithErrors)
- [`graphql:PayloadBindingError` error - API documentation](https://lib.ballerina.io/ballerina/graphql/1.5.0/errors#PayloadBindingError)
- [GraphQL client - Specification](/spec/graphql/#25-client)
