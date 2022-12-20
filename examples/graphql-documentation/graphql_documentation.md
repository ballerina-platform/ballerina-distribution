# GraphQL service - Documentation

The Ballerina `graphql` module allows adding documentation to the `graphql:Service` and its subsequent types. To add documentation, use the Ballerina doc comments for the `graphql:Service`, `resource`/`remote` methods, types, and `enum`s. Add the documentation to include the descriptions to the generated GraphQL schema.

::: code graphql_documentation.bal :::

Run the service by executing the following command.

::: out graphql_documentation.server.out :::

Send the following document with an introspection query to test how the documentation is added to the schema.

::: code graphql_documentation.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_documentation.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL documentation - Specification](/spec/graphql/#35-documentation)
