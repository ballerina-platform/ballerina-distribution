# GraphQL service - Caching

The Ballerina `graphql` module allows enabling GraphQL caching. To enable the GraphiQL caching, use the `cacheConfig` field in the `graphql:ResourceConfig` annotation on a resource path in a `graphql:Service`. Also, by using the `cacheConfig` field in the `graphql:ServiceConfig` annotation on a service can enable GraphQL caching for all the operations in the `graphql:Service`.

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
- [GraphQL Caching - Specification](/spec/graphql/#??????)
