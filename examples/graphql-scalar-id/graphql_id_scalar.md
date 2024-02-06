# GraphQL service - ID Scalar Type

The Ballerina `graphql` module supports `ID` scalar type. The GraphQL `ID` type is used to represent unique identifiers in a GraphQL schema. It is a built-in scalar type that can be used to define input parameters for GraphQL fields. The `@graphql:ID` annotation can be applied to specific fields, indicating that they correspond to the GraphQL `ID` scalar type. When the `@graphql:ID` annotation is used, the generated schema will show the field type as `ID`, regardless of the actual type of the field.

::: code graphql_id_scalar.bal :::

Run the service by executing the following command.

::: out graphql_id_scalar.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_id_scalar.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_id_scalar.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL input types - Specification](/spec/graphql/#415-id)
