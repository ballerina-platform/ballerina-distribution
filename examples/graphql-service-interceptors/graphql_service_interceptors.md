# GraphQL service - Service interceptors

The `graphql:Service` allows adding interceptors for GraphQL requests to execute custom logic. An interceptor can be defined using a `readonly` class that includes the `graphql:Interceptor` type. The interceptor class must implement the `execute` remote method, which is defined in the `graphql:Interceptor` service object type. They can be passed as an array using the `interceptors` field in the `graphql:ServiceConfig` annotation. The provided interceptors will be executed using the `_onion principle_`. Use the interceptors to execute custom logic before and after executing the `resource` and `remote` methods that need to be separated from the business logic.

>**Note:** A service can have zero or more interceptors.

::: code graphql_service_interceptors.bal :::

Run the service by executing the following command.

::: out graphql_service_interceptors.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_service_interceptors.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_service_interceptors.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql:Interceptor` object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Interceptor)
- [GraphQL service interceptors - Specification](/spec/graphql/#10331-service-interceptors)
