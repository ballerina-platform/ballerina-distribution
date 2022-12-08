# Subscriptions

A GraphQL schema can have interfaces where an interface specifies a set of fields that multiple object types can include. In Ballerina, interfaces are defined using `distinct` `service` objects and the fields of the interfaces are defined as resource method definitions. Objects that are implementing the interfaces must implement the `resource` methods defined in the service objects. The Ballerina type inclusion is used to include the interface type to an object type.

Interfaces are useful when you want to return an object or set of objects, but those might be of several different types. Fields defined in the interface are always queryable. Therefore, a client can query those fields without knowing an exact object type.

This example shows how to define an interface `Profile` and then implement the `Teacher` and `Student` classes using that interface.

::: code graphql_subscriptions.bal :::

Run the service by executing the following command.

::: out graphql_subscriptions.server.out :::

Send the following document to the GraphQL endpoint to test the service using any GraphQL client that supports subscriptions to test the service.

>**Tip:** You can invoke the above service via the [GraphiQL client](/learn/by-example/graphql-graphiql/).

::: code graphql_subscriptions.graphql :::

It should return the following values.

::: out graphql_subscriptions.client.out :::

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL `Subscription` type - Specification](/spec/graphql/#313-the-subscription-type)
