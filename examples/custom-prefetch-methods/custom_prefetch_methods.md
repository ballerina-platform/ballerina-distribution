# GraphQL service - Custom prefetch methods

The `prefetchMethodName` field of the `graphql:ResourceConfig` annotation is used to override the default prefetch method name. This configuration is useful when the Query and Mutation operations have fields with the same name, and the user wants to use different prefetch methods for each field, or when the user wants to use a different name for some other reason. To override the default prefetch method name, annotate the target field with the `graphql:ResourceConfig` annotation and specify the prefetch method name as the value of the `prefetchMethodName` field.

::: code graphql_prefetch_config.bal :::

Run the service by executing the following command.

::: out graphql_prefetch_config.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_prefetch_config.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_prefetch_config.client.out :::

## Related links
- [Prefetch Method Name Configuration - Specification](/spec/graphql/#722-prefetch-method-name-configuration)
- [The `prefetch` Method - Specification](/spec/graphql/#10633-define-the-corresponding-prefetch-method)
