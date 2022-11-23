# GraphQL service - Hierarchical resource paths

The resources in Ballerina GraphQL services can have hierarchical resource paths. When a hierarchical path is present, an `OBJECT` type is created for each intermediate path segment with the same name. Every sub path under a path segment will be added as a field of the created type.

This example shows a GraphQL endpoint, which has a `profile` field of type `Person`. A GraphQL client can query this service to retrieve specific fields or subfields of the `Person` object.

::: code graphql_hierarchical_resource_paths.bal :::

Run the service by executing the following command.

::: out graphql_hierarchical_resource_paths.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_hierarchical_resource_paths.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_hierarchical_resource_paths.client.out :::

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [`graphql` hierarchical resource paths - Specification](/spec/graphql/#333-hierarchical-resource-path)
