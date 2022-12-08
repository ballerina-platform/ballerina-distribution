# GraphQL service - Hierarchical resource paths

The resources in Ballerina GraphQL services can have hierarchical resource paths. When a hierarchical path is present, an `OBJECT` type is created for each intermediate path segment with the same name. Every sub-path under a path segment will be added as a field of the created type.

You may use hierarchical resource paths if you do not want to explicitly define an `OBJECT` type using `record` or `service` types.

This example shows a GraphQL endpoint, which has a `profile` field of type `profile!`. A GraphQL client can query this service to retrieve specific fields or subfields of the `Profile` object.

::: code graphql_hierarchical_resource_paths.bal :::

Run the service by executing the following command.

::: out graphql_hierarchical_resource_paths.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_hierarchical_resource_paths.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_hierarchical_resource_paths.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL hierarchical resource paths - Specification](/spec/graphql/#333-hierarchical-resource-path)
