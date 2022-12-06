# GraphQL service - Input types

GraphQL resources can have input parameters, which will be mapped to input values in the generated GraphQL schema.

Inputs can be optional and/or defaultable types. If an input is optional, it will be mapped to a nullable type in the GraphQL schema. If an input has a default value, it will be added as a default value in the GraphQL schema.

This example shows a GraphQL endpoint, which has field `greeting` in the root `Query` type, with an input argument `name` of type `String!`.

::: code graphql_input_types.bal :::

Run the service by executing the following command.

::: out graphql_input_types.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_input_types.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_input_types.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL input types - Specification](/spec/graphql/#45-input-types)
