# Subscriptions

A resource function with the `subscribe` accessor inside a GraphQL service represents a field in the root `Subscription` type. Therefore, if a resource function with the `subscribe` accessor is present inside the Ballerina GraphQL service, the auto-generated schema will have a `Subscription` type.

A resource function with `subscribe` accessor must return a `stream` type. Not returning a `stream` type will result in a compilation error.

Each resource function with the `subscribe` accessor in the service will be added as a field of the `Subscription` type. The field name will be the resource function name and the field type will be the constraint type of the stream returned from the resource function.

This example shows a GraphQL endpoint, which has a field `names` in the root `Subscription` type.

::: code graphql_subscriptions.bal :::

Run the service by executing the following command.

::: out graphql_subscriptions.server.out :::

Send the following document to the GraphQL endpoint to test the service using any GraphQL client that supports subscriptions to test the service.

>**Info:** You can invoke the above service via the [GraphiQL](/learn/by-example/graphql-graphiql/).

::: code graphql_subscriptions.graphql :::

It should return the following values.

::: out graphql_subscriptions.client.out :::

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest).
- [`graphql` subscription type - Specification](/spec/graphql/#313-the-subscription-type).
