# GraphQL service - Union Types

A GraphQL schema can have union types, that can include two or more `OBJECT` types. In Ballerina, `distinct` `service` objects can be used to define members of a union type. Then a Ballerina union type can be used to define the GraphQL union type. Use a union type to represent a type that consists of a set of possible `OBJECT` types, but provide no guarantee for common fields.

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
