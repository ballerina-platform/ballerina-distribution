# GraphQL service - Hierarchical resource paths

The Ballerina `graphql` module allows using hierarchical resource paths in the GraphQL resources. When hierarchical resource paths are used, a GraphQL output object type is created for each intermediate path segment with the same name. Every sub-path under a path segment is added as a field of the created type. Hierarchical paths can be used when there is no need to define the GraphQL output object types explicitly.

::: code graphql_hierarchical_resource_paths.bal :::

Run the service by executing the following command.

::: out graphql_hierarchical_resource_paths.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_hierarchical_resource_paths.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_hierarchical_resource_paths.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL hierarchical resource paths - Specification](/spec/graphql/#333-hierarchical-resource-path)
