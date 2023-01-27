# GraphQL service - Field object

The Ballerina `graphql` module exposes information on a GraphQL field in a document using the `graphql:Field` object. When the `graphql:field` is needed to be accessed, define it as a parameter of the `resource`/`remote` method that represents a GraphQL field. Use the `graphql:Field` object in scenarios where the information about the fields such as subfield names and field type are needed for optimizing the business logic such as query optimizations.

>**Hint:** The `graphql:Field` is defined before the other parameters of a function as a convention.

>**Note:** If the `graphql:Field` is defined as a parameter of a resolver function, it will be accessible inside the resolver. Passing it down is not necessary.

::: code graphql_service_field_object.bal :::

Run the service by executing the following command.

::: out graphql_service_field_object.server.1.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_service_field_object.1.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_service_field_object.1.client.out :::

This will print a log message in the server stdout similar to the following log, verifying that the `address` field is not queried.

::: out graphql_service_field_object.server.2.out :::

Now, send the following document where the `address` field is queried.

::: code graphql_service_field_object.2.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_service_field_object.2.client.out :::

This will print a log message in the server stdout similar to the following log, verifying that now the `address` field is queried.

::: out graphql_service_field_object.server.3.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links

- [`graphql:Field` object - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/classes/Field)
- [GraphQL field - Specification](/spec/graphql/#9-field-object)
