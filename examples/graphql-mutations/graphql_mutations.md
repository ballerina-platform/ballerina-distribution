# GraphQL service - Mutations

A remote function inside a GraphQL service represents a field in the root `Mutation` object type. Therefore, if a remote function is present inside the Ballerina GraphQL service, the auto-generated schema will have the `Mutation` type. Each remote function in the service will be added as a field of the `Mutation` type. The field name will be the remote function name and the field type will be the return type of the remote function.

This example shows a GraphQL endpoint, which has a field named `updateName` in the root `Mutation` type. The type of the field is of type `Person!`.

::: code graphql_mutations.bal :::

Run the service by executing the following command.

::: out graphql_mutations.server.out :::

Then, send the following document to update the name.

::: code graphql_mutations.graphql :::

To send the document, use the following cURL command.

::: out graphql_mutations.client.out :::

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [`graphql` mutation type - Specification](/spec/graphql/#312-the-mutation-type)
