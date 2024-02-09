# GraphQL service - Operation-level caching

The Ballerina `graphql` module provides the capability to enable GraphQL caching. GraphQL caching can be enabled at either the field level or the operation level. To enable caching at the operation level, the `cacheConfig` field in the `graphql:ServiceConfig` annotation can be applied on a service. This configuration will enable caching for all resource paths within the `graphql:Service`.

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
- [GraphQL Caching - Specification](/spec/graphql/#1071-server-side-caching)
