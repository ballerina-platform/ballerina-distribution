# GraphQL service - Error handling

The Ballerina `graphql` module allows returning `error`s from the `resource` and `remote` methods used as GraphQL object fields. If a field returns an error, it will be added in the GraphQL response under the `errors` field while the field value is set to `null`. In this case, if the GraphQL field type is `NON_NULL`, the `null` value is propagated to the upper levels until a `null` value is allowed as the field value. This might cause the whole `data` field to be `null` in some cases. Alternatively, the field type can include nil, so the field value can be `null`. In that case, the `null` value is not propagated to the upper levels in the response.

::: code graphql_service_error_handling.bal :::

Run the service by executing the following command.

::: out graphql_service_error_handling.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_service_error_handling.1.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_service_error_handling.1.client.out :::

Check the response to see how both the `errors` and the `data` fields are present in the response.

Now, send the following document to the GraphQL endpoint.

::: code graphql_service_error_handling.2.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_service_error_handling.2.client.out :::

Check the response to see how the `data` field is set to null due to propagating the `null` value because the `name` field and the `profile` field are of `NON_NULL` type.

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL union types - Specification](/spec/graphql/#43-unions)
