# GraphQL service - Cache invalidation

The Ballerina `graphql` module provides functionality for cache invalidation. The `invalidate()` and `invalidateAll()` APIs in the `graphql:Context` can be used to invalidate caches in a `graphql:Service`. The `invalidate()` API supports the cache invalidation of a specific field by providing the full path of the field separated by a full stop(`.`). For example, `invalidate("field.subfield.anotherSubfield")`. Conversely, the `invalidateAll()` API invalidates all caches within the `graphql:Service`.

::: code graphql_service_cache_invalidation.bal :::

Run the service by executing the following command.

::: out graphql_service_cache_invalidation.server.out :::

Then, send the following document to update the name.

::: code graphql_service_cache_invalidation.graphql :::

To send the document, execute the following cURL command.

::: out graphql_service_cache_invalidation.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL Caching - Specification](/spec/graphql/#1071-server-side-caching)
