# GraphQL service - Input objects

The Ballerina `graphql` module allows defining GraphQL input objects in a `graphql:Service` using Ballerina records. To define a GraphQL input object, define a record type in Ballerina and use it as an input type in a `resource` or a `remote` method inside a `graphql:Service`. Use GraphQL input objects to define non-primitive, structured input arguments in a GraphQL API.

::: code graphql_input_objects.bal :::

Run the service by executing the following command.

::: out graphql_input_objects.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_input_objects.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_input_objects.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL input objects - Specification](/spec/graphql/#452-input-objects)
