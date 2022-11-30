# GraphQL service - Hello world

A GraphQL service in Ballerina represents a GraphQL schema. Each resource method of the `graphql:Service` with the `get` accessor represents a resolver function in the root `Query` type. The return type of each resource method will be the type of each field represented by the resource method.

This example shows a GraphQL endpoint that has a field named `greeting` in the root `Query` type which is of type `String!`.

::: code graphql_hello_world.bal :::

Run the service by executing the following command.

::: out graphql_hello_world.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_hello_world.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_hello_world.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [`graphql` query type - Specification](/spec/graphql/#311-the-query-type)
