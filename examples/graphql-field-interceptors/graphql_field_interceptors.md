# GraphQL service - Field Interceptors

The GraphQL resolver functions allow adding interceptors for GraphQL requests to execute custom logic. An interceptor can be defined using a `readonly` class that includes the `graphql:Interceptor` type. The interceptor class must implement the `execute` remote method, which is defined in the `graphql:Interceptor` service object type. It can be passed as a single interceptor or an array of interceptors using the `interceptors` field in the `graphql:ResourceConfig` annotation. The provided interceptors will be executed using the _onion principle_. Use the field interceptors to execute custom logic before and after executing a `resource` or a `remote` method that needs to be separated from the business logic.

>**Note:** A resolver can have zero or more interceptors.

::: code graphql_field_interceptors.bal :::

Run the service by executing the following command.

::: out graphql_field_interceptors.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_field_interceptors.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_field_interceptors.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql:Interceptor` object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Interceptor)
- [GraphQL interceptors - Specification](/spec/graphql/#11-interceptors)
