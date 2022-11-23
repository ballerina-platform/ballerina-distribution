# GraphQL service - Documentation

A GraphQL schema can include documentation for the schema. These documentation can help you to understand the schema. In Ballerina, the Ballerina doc comments can be used to add documentation to various schema members.

This example shows how to add doc comments to the GraphQL service so that the generated schema will include them as the documentation.

::: code graphql_documentation.bal :::

Run the service by executing the following command.

::: out graphql_documentation.server.out :::

Send the following document with an introspection query to test how the documentation is added to the schema.

::: code graphql_documentation.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_documentation.client.out :::

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [`graphql` documentations - Specification](/spec/graphql/#5-directives)
