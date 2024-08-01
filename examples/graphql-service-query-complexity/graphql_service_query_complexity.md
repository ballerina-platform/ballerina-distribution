# GraphQL service - Query Complexity

a `graphql:Service` can be secured by limiting the complexity of the operations that can be executed. This can be done by setting a maximum complexity threshold for a given service. The query complexity is calculated by assigning a complexity value to each field in the GraphQL schema. The complexity of an operation is the sum of the complexity values of the fields in the operation.

::: code graphql_service_query_complexity.bal :::

Run the service by executing the command below.

::: out graphql_service_query_complexity.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_service_query_complexity.1.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_service_query_complexity.client.1.out :::

As shown in the output above, the query is executed without any issues. Now, send the following document to the GraphQL endpoint.

::: code graphql_service_query_complexity.2.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_service_query_complexity.client.2.out :::

This will result in an error as the query complexity exceeds the maximum complexity threshold set for the service.

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links

- [`graphql:ServiceConfig` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ListenerConfiguration)
- [`graphql:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ListenerSecureSocket)
- [GraphQL service SSL/TLS - Specification](/spec/graphql/#8311-ssltls)
