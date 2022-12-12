# GraphQL client - Handle partial response

A GraphQL service can return a partial response having both errors and data fields when there are errors occurred during the execution of a field on the service side. If a field is allowed to have a null value in the GraphQL schema, then when defining the user-defined types on the client side, that field needs to be specified as a nullable field. Otherwise a `graphql:PayloadBindingError` may be returned when calling the client `execute()` method.

This example shows how to retrieve the partial data and graphql field errors in a user-defined type.

::: code graphql_client_handle_partial_response.bal :::

## Prerequisites
- Run the GraphQL service given in the [Record as output object](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_handle_partial_response.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/clients/Client)
- [`graphql:GenericResponseWithErrors` record - API documentation](https://lib.ballerina.io/ballerina/graphql/1.4.4/records/GenericResponseWithErrors)
- [`graphql:PayloadBindingError` error - API documentation](https://lib.ballerina.io/ballerina/graphql/1.5.0/errors#PayloadBindingError)
- [GraphQL client - Specification](/spec/graphql/#25-client)
