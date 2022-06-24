# Hierarchical resource paths

The resources in Ballerina GraphQL services can have hierarchical resource
paths. When a hierarchical path is present, an `OBJECT` type is created for
each intermediate path segment with the same name. Every sub path under a
path segment will be added as a field of the created type.<br/><br/>
For more information on the underlying package, see the
[GraphQL package](https://docs.central.ballerina.io/ballerina/graphql/latest/).<br/><br/>
This example shows a GraphQL endpoint, which has a `profile` field of type `Person`.
A GraphQL client can query this service to retrieve specific fields or subfields of the `Person` object.

::: code graphql_hierarchical_resource_paths.bal :::

::: out graphql_hierarchical_resource_paths.client.out :::

::: out graphql_hierarchical_resource_paths.server.out :::