# GraphQL service - Mutations

A remote function inside a GraphQL service represents a field in the root `Mutation` object type. Therefore, if a remote function is present inside the Ballerina GraphQL service, the auto-generated schema will have the `Mutation` type. Each remote function in the service will be added as a field of the `Mutation` type. The field name will be the remote function name and the field type will be the return type of the remote function.

This example shows a GraphQL endpoint, which has `updateName` and `updateAge` fields in the root `Mutation` type. Both the fields are of type `Person!`.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_mutations.bal :::

Run the service by executing the following command.

::: out graphql_mutations.server.out :::

First, send the following document to the GraphQL endpoint to test the service.

::: code graphql_mutations.1.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_mutations.1.client.out :::

Now, send the following document to update the name.

::: code graphql_mutations.2.graphql :::

To send the document, use the following cURL command.

::: out graphql_mutations.2.client.out :::

Finally, send the following document to update the age.

::: code graphql_mutations.3.graphql :::

To send the document, use the following cURL command.

::: out graphql_mutations.3.client.out :::
