# GraphQL service - Subscriptions

The Ballerina `graphql` module allows defining GraphQL `Subscription` operations. A resource method with the `subscribe` accessor inside a GraphQL service represents a field in the root `Subscription` type. Therefore, If a resource method with the `subscribe` accessor is present inside the Ballerina GraphQL service, the auto-generated schema will have a `Subscription` type. Each resource method with a `subscribe` accessor in the service is added as a field of the `Subscription` type. The field name will be the resource method name and the field type will be the constraint type of the `stream` returned from the resource method. Not returning a `stream` type from a resource method having a `subscribe` accessor results in a compilation error. Use a subscription operation to monitor small, incremental changes to large objects or to obtain low-latency, real-time updates.

::: code graphql_subscriptions.bal :::

Run the service by executing the following command.

::: out graphql_subscriptions.server.out :::

Send the following document to the GraphQL endpoint to test the service using any GraphQL client that supports subscriptions to test the service.

::: code graphql_subscriptions.graphql :::

It should return the following values.

::: out graphql_subscriptions.client.out :::

>**Tip:** You can invoke the above service via the [GraphiQL client](/learn/by-example/graphql-graphiql/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL `Subscription` type - Specification](/spec/graphql/#313-the-subscription-type)
