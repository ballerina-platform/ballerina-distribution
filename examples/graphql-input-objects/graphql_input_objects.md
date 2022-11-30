# GraphQL service - Input objects

GraphQL resolvers can have record types as input parameters, which will be mapped to an `INPUT_OBJECT` in the generated GraphQL schema. The input parameters of the resolver function will be added as input arguments of the corresponding field in the generated GraphQL schema.

According to the GraphQL specification, an input type cannot be used as an output type. Therefore, using the same type as an input and an output will result is a compilation error.

This example shows a GraphQL endpoint, which has a field `addProfile` with an input of type `NewProfile!` in the root `Mutation` type.

::: code graphql_input_objects.bal :::

Run the service by executing the following command.

::: out graphql_input_objects.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_input_objects.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_input_objects.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [`graphql` input objects - Specification](/spec/graphql/#452-input-objects)
