# GraphQL service - Mutations

The Ballerina `graphql` module allows defining GraphQL `Mutation` operations. A `remote` method inside a `graphql:Service` represents a field in the root `Mutation` object type. Therefore, if a `remote` method is present inside the `graphql:Service`, the auto-generated schema will have the `Mutation` type. Each `remote` method in the service will be added as a field of the `Mutation` type. The field name will be the `remote` method name and the field type will be the return type of the `remote` method. Use the `Mutation` operation when performing any side-effects on the underlying data system.

::: code graphql_mutations.bal :::

Run the service by executing the following command.

::: out graphql_mutations.server.out :::

Then, send the following document to update the name.

::: code graphql_mutations.graphql :::

To send the document, use the following cURL command.

::: out graphql_mutations.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL `Mutation` type - Specification](/spec/graphql/#312-the-mutation-type)
