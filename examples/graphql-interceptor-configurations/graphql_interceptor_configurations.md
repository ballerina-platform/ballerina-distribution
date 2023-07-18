# GraphQL service - Interceptor configurations

A GraphQL interceptor can be configured to change the behavior of an interceptor. It can be configured via the `graphql:InterceptorConfig` annotation. The `graphql:InterceptorConfig` includes the `global` field, which accepts a boolean value to define the scope of the interceptor.

- If the `global` field is set to `true`, the interceptor will be applied to each field and subfield of the service.
- If the `global` field is set to `false`, the interceptor will be applied only to the fields of the service, but not to the subfields of the service.

>**Info:** By default, the `global` flag is set to `true`. Use `global: false` to apply the interceptor functionality only to an entry point of the GraphQL service. The scope configuration is applied only to the GraphQL `service interceptors`.

::: code graphql_interceptor_configurations.bal :::

Run the service by executing the following command.

::: out graphql_interceptor_configurations.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interceptor_configurations.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_interceptor_configurations.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql:InterceptorConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#InterceptorConfig)
- [GraphQL interceptor configuration - Specification](/spec/graphql/#73-interceptor-configuration)
- [GraphQL interceptors - Specification](/spec/graphql/#103-interceptors)
