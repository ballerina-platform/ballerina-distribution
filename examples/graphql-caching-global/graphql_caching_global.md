# GraphQL service - Operational Level Caching

The Ballerina `graphql` module allows enabling GraphQL caching. GraphQL caching can be enabled on either field level or operational level. To enable the caching in operational level, use the `cacheConfig` field in the `graphql:ServiceConfig` annotation on a service. This will enable caching for all the resource paths in the `graphql:Service`.

::: code graphql_caching_global.bal :::

Run the service by executing the following command.

::: out graphql_caching_global.server.out :::

Then, send the following document to update the name.

::: code graphql_caching_global.graphql :::

To send the document, execute the following cURL command.

::: out graphql_caching_global.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL Caching - Specification](/spec/graphql/#??????)
