# GraphQL service - Directives

The Ballerina `graphql` module allows using the following set of pre-defined directives.

- `@depricated` - The `@deprecated` annotation can be used as the `deprecated` directive on the `resource` or `remote` methods and `enum` values. Use this to mark a field or an enum value as deprecated.
- `@skip(if: Boolean!)` - The `@skip` directive can be used on fields or fragments in GraphQL documents. Use this to skip a field execution based on the given condition.
- `@include(if: Boolean!)` - The `@include` directive can be used on fields or fragments in GraphQL documents. Use this to include a field execution based on the given condition.

::: code graphql_directives.bal :::

Run the service by executing the following command.

::: out graphql_directives.server.out :::

The requests below demonstrate the usage of the `@skip` and `@include` directives. Invoke the service using the following cURL command to inspect the result.

Send the following document containing the `@skip` directive to test it.

::: code graphql_directives.1.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_directives.1.client.out :::

Then, send the following document containing the `@include` directive.

::: code graphql_directives.2.graphql :::

To send the document, use the following cURL command.

::: out graphql_directives.2.client.out :::

Finally, send the following document with an introspection query to check the deprecated enum values.

::: code graphql_directives.3.graphql :::

To send the document, use the following cURL command.

::: out graphql_directives.3.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL directives - Specification](/spec/graphql/#5-directives)
