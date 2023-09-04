# GraphQL service - Custom prefetch methods

A prefetch method in the context of Ballerina GraphQL is a method that is invoked before the actual resolver method. By default the prefetch method name has the convention of having the prefix `pre` followed by the resolver method name. 

If you want to use a custom prefetch method, the `prefetchMethodName` field of the `graphql:ResourceConfig` annotation can be used to override the default prefetch method name. This configuration is useful when the Query and Mutation operations have fields with the same name, and when it is required to use different prefetch methods for each field. To override the default prefetch method name, annotate the target field with the `graphql:ResourceConfig` annotation and specify the prefetch method name as the value of the `prefetchMethodName` field.

::: code custom_prefetch_methods.bal :::

Run the service by executing the following command.

::: out custom_prefetch_methods.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code custom_prefetch_methods.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out custom_prefetch_methods.client.out :::

## Related links
- [`graphql:ResourceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ResourceConfig)
- [Prefetch Method Name Configuration - Specification](/spec/graphql/#722-prefetch-method-name-configuration)
- [The `prefetch` Method - Specification](/spec/graphql/#10633-define-the-corresponding-prefetch-method)
