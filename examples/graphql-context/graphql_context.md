# GraphQL service - Context

The Ballerina `graphql` module allows defining and using a `graphql:Context` object. The `contextInit` field in the `graphql:ServiceConfig` annotation can be used to pass the context initialization function. If it is not provided, a default, empty `context` object will be created per request. When the `graphql:Context` is needed to be accessed, define it as the first parameter of the `resource`/`remote` method. Use the `graphql:Context` to pass meta information between the `resource`/`remote` methods used as GraphQL object fields.

>**Note:** If the `graphql:Context` is defined as the first parameter of a resolver function, it will be accessible inside the resolver. Passing down the context is not necessary.

This example shows how to initialize and access the context as well as how to set/get attributes in the context.

::: code graphql_context.bal :::

Run the service by executing the following command.

::: out graphql_context.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_context.graphql :::

To send the document, use the following cURL command in a separate terminal. First, send the request with the `scope` header value set to `admin`.
::: out graphql_context.1.client.out :::

Now, send the same document with the `scope` header value set to `unknown`. This will return an error in the `profile` field.

::: out graphql_context.2.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql:Context` object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/classes/Context)
- [GraphQL context - Specification](/spec/graphql/#8-context)
