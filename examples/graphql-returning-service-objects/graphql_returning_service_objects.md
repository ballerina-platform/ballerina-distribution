# GraphQL service - Service as output object

A GraphQL resource method can return service objects. The returning service objects are mapped to an `OBJECT` type in the GraphQL schema. Each resource method in the returned service object becomes a field in the created `OBJECT` type.

Even though both the record and service types can be used to represent an `OBJECT` type, using a service type provides the flexibility of organizing complex logic and allows GraphQL fields to have input arguments.

This example shows a GraphQL endpoint, which has a field `profile` of type `Profile!` in the root `Query` type. A GraphQL client can query this service to retrieve specific fields or subfields of the `Profile` object.

>**Note:** A record type can also be used to represent an `OBJECT` type when no fields in the `OBJECT` type do not have input arguments.

::: code graphql_returning_service_objects.bal :::

Run the service by executing the following command.

::: out graphql_returning_service_objects.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_returning_service_objects.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_returning_service_objects.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL service type as object - Specification](/spec/graphql/#422-service-type-as-object)
