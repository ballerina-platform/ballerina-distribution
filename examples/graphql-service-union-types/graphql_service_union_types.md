# GraphQL service - Union Types

The Ballerina `graphql` module allows defining union types as defined in the GraphQL specification. However, the Ballerina union type that represents a GraphQL union type can only consist of `distinct` `service` classes. This is because the Ballerina type system is structurally-typed, whereas, the GraphQL type system is nominally-typed. The `distinct` types are the only types of Ballerina, which have the similar behavior to nominal types. Use union types when an API requires a type that consists of more than one type.

::: code graphql_service_union_types.bal :::

Run the service by executing the following command.

::: out graphql_service_union_types.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_service_union_types.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_service_union_types.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL union types - Specification](/spec/graphql/#43-unions)
