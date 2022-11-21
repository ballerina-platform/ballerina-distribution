# GraphQL service - Context

The `graphql:Context` object can be used to pass meta information between the resolver functions. A context object is created per request. An init function should be provided using the `graphql:ServiceConfig` parameter named `contextInit`.

Inside the init function, the `graphql:Context` can be initialized. The corresponding `http:RequestContext` and `http:Request` can be accessed from the init function.

You can add attributes to the context as key-value pairs. The key is a `string` and the value can be any `readonly` value or an `isolated` object. If the init function is not provided, an empty context object will be created. The context can be accessed by defining it as the first parameter of any resolver (resource/remote) function.

This example shows how to initialize and access the context as well as how to set/get attributes in the context.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_context.bal :::

Run the service by executing the following command.

::: out graphql_context.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_context.graphql :::

To send the document, use the following cURL command in a separate terminal. First, send the request with the `scope` header value set to `admin`.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_context.1.client.out :::

Now, send the same document with the `scope` header value set to `user`. This will return an error in the `salary` field.

::: out graphql_context.2.client.out :::

Then, send the same document with the `scope` header value set to `unknown`. This will return an error in the `profile` field.

::: out graphql_context.3.client.out :::
