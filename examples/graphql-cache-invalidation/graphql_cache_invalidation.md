# GraphQL service - Cache invalidation

The Ballerina `graphql` module provides functionality for cache invalidation. The `invalidate()` and `invalidateAll()` APIs in the `graphql:Context` can be used to invalidate caches in a `graphql:Service`. To invalidate a specific cache in a `resource` method, the `invalidate()` API requires to specify the name of the resource method. On the other hand, the `invalidateAll()` API invalidates all caches within the service.

::: code graphql_cache_invalidation.bal :::

Run the service by executing the following command.

::: out graphql_cache_invalidation.server.out :::

Then, send the following document to update the name.

::: code graphql_cache_invalidation.graphql :::

To send the document, execute the following cURL command.

::: out graphql_cache_invalidation.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL Caching - Specification](/spec/graphql/#1071-server-side-caching)
