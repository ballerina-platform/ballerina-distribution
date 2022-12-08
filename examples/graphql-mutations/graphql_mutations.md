# GraphQL service - Mutations

A remote method inside a GraphQL service represents a field in the root `Mutation` object type. Therefore, if a remote method is present inside the Ballerina GraphQL service, the auto-generated schema will have the `Mutation` type. Each remote method in the service will be added as a field of the `Mutation` type. The field name will be the remote method name and the field type will be the return type of the remote method. 

Use Mutation when inserting, updating, deleting or performing any side-effects on the underlying data system.

This example shows a GraphQL endpoint, which has a field named `updateName` in the root `Mutation` type. The type of the field is of type `Profile!`.

::: code graphql_mutations.bal :::

Run the service by executing the following command.

::: out graphql_mutations.server.out :::

Then, send the following document to update the name.

::: code graphql_mutations.graphql :::

To send the document, use the following cURL command.

::: out graphql_mutations.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL `Mutation` type - Specification](/spec/graphql/#312-the-mutation-type)
