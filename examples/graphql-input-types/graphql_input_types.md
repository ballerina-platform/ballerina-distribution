# GraphQL service - Input types

The Ballerina GraphQL module allows defining input parameters for the GraphQL fields. To define input parameters, add the desired input parameters in the `resource` and `remote` methods in a `graphql:Service` and the subsequent service types.

::: code graphql_input_types.bal :::

Run the service by executing the following command.

::: out graphql_input_types.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_input_types.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_input_types.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL input types - Specification](/spec/graphql/#45-input-types)
