# GraphQL service - Hello world

A `graphql:Service` in Ballerina represents a GraphQL schema. Each resource method of the `graphql:Service` with the `get` accessor represents a resolver function in the root `Query` type. The return type of the `resource` method will be the type of field represented by that resource method.

>**Note:** GraphQL queries are expected to be read-only operations that are usually executed against entities such as `Person`, `Profile`, `Address`, etc. Ballerina uses `resource` methods to handle such cases. Therefore, these `resource` methods are usually named using nouns with `get` accessor.

::: code graphql_hello_world.bal :::

Run the service by executing the following command.

::: out graphql_hello_world.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_hello_world.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_hello_world.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL `Query` type - Specification](/spec/graphql/#311-the-query-type)
