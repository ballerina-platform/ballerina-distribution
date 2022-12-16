# GraphQL service - Record as output object

The Ballerina `graphql` module allows returning `record` types from the `resource` or `remote` methods of the `graphql:Service`. These `record` types are mapped to GraphQL output object types in the GraphQL schema in which the type name and the field names are mapped one-to-one from Ballerina to GraphQL. 
Use a `record` type to represent a GraphQL output object type only when all fields of that object type do not have any input arguments or the field resolution does not require any complex logic execution. The `record` type is preferred over the `service` object type in this case as it makes the code more concise.


::: code graphql_returning_record_values.bal :::

Run the service by executing the following command.

::: out graphql_returning_record_values.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_returning_record_values.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_returning_record_values.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL record type as object - Specification](/spec/graphql/#421-record-type-as-object)
