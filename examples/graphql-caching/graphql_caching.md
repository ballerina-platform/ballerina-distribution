# GraphQL service - Field Level Caching

The Ballerina `graphql` module provides the capability to enable GraphQL caching, which can be applied at either the field or operational level. To enable caching at the field level, the `cacheConfig` field in the `graphql:ResourceConfig` annotation can be used on a resource path within a `graphql:Service`. By setting this configuration, caching is enabled for the specified resource path, and it can override cache configurations at the operation level.

::: code graphql_caching.bal :::

Run the service by executing the following command.

::: out graphql_caching.server.out :::

Then, send the following document to update the name.

::: code graphql_caching.graphql :::

To send the document, execute the following cURL command.

::: out graphql_caching.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL Caching - Specification](/spec/graphql/#107-caching)
