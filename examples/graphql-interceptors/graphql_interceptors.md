# GraphQL service - Interceptors

The GraphQL `interceptors` can be used to execute custom logic before and after the resolver function gets invoked. It can be defined as a read-only service class, which includes the `graphql:Interceptor` service object.

The interceptor service class should implement the `execute(graphql:Context context, graphql:Field 'field)` remote method, which is provided by the interceptor service object. The custom logic can be included in this remote method. The interceptors should be provided using the `graphql:ServiceConfig` parameter named `interceptors`, which accepts an array of interceptor instances.

Interceptors follow the _onion principle_ when executing. Also, the inserting order of the interceptor instances into the array will be the execution order of the interceptors.

This example shows how to define an interceptor to print a log before and after a resolver is executed.

::: code graphql_interceptors.bal :::

Run the service by executing the following command.

::: out graphql_interceptors.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interceptors.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_interceptors.client.out :::

## Related Links
- [`graphql:Interceptor` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/objectTypes/Interceptor).
- [`graphql` input types - Specification](/spec/graphql/#10-interceptors).
