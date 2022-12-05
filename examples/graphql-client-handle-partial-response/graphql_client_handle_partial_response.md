# GraphQL client - Handle partial response

A GraphQL service can return a partial response having both errors and data fields when there are `Field errors` raised at the service side during the execution of an operation.

This example shows how to retrieve the partial data and graphql `Field errors` in a user-defined type.

::: code graphql_client_handle_partial_response.bal :::

## Prerequisites
- Run the GraphQL service given in the [Record as output object](https://ballerina.io/learn/by-example/graphql-returning-record-values) example.

Run the client program by executing the following command.

::: out graphql_client_handle_partial_response.out :::

## Related links
- [`graphql:Client` client object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/clients/Client)
- [`graphql:GenericResponseWithErrors` record - API documentation](https://lib.ballerina.io/ballerina/graphql/1.4.4/records/GenericResponseWithErrors)
- [GrapHQL client - Specification](/spec/graphql/#25-client)
