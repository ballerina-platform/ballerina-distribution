# GraphQL service - Service as output object

The Ballerina `graphql` module allows returning `service` objects from the `resource` or `remote` methods of the `graphql:Service`. These `service` objects are mapped to GraphQL output object types in the GraphQL schema. Each `resource` method in the returned `service` object becomes a field in the created GraphQL output object type. The `resource` methods in these `service` types can have input parameters. These input parameters are mapped to arguments in the corresponding field. Use a `service` type to represent a GraphQL output object type when a field of that GraphQL output object type has any input arguments. Further, using a `service` type to represent a GraphQL output object type offers the flexibility of organizing complex logic.

::: code graphql_returning_service_objects.bal :::

Run the service by executing the following command.

::: out graphql_returning_service_objects.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_returning_service_objects.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_returning_service_objects.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL service type as object - Specification](/spec/graphql/#422-service-type-as-object)
