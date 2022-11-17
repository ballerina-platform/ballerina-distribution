# Directives

The Ballerina GraphQL supports the following GraphQL directives.

`@depricated` - Marks the schema definition of a field or enum value as deprecated with an optional reason.
`@skip(if: Boolean!)` - If true, the decorated field or fragment in an operation is not resolved by the GraphQL server.
`@include(if: Boolean!)` - If false, the decorated field or fragment in an operation is not resolved by the GraphQL server.

This example shows how to use GraphQL directives in Ballerina GraphQL services.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_directives.bal :::

Run the service by executing the following command.

::: out graphql_directives.server.out :::

The requests below demonstrate the usage of the `@skip` and `@include` directives. Invoke the service using the
following cURL command to inspect the result.

Send the following document containing the `@skip` directive to test it.

```graphql
{
    profile {
        name
        address @skip(if: true) {
            city
        }
    }
}
```

To send the document, use the following cURL command in a separate terminal.

::: out graphql_directives.1.client.out :::

Then, send the following document containing the `@include` directive.

```graphql
{
    profile {
        name
        address @include(if: true) {
            city
        }
    }
}
```

To send the document, use the following cURL command.

::: out graphql_directives.2.client.out :::

Finally, send the following document with an introspection query to check the deprecated enum values.

```graphql
{
    __type(name: "Gender") {
        name
        enumValues {
            name
            isDeprecated
            deprecationReason
        }
    }
}
```

To send the document, use the following cURL command.

::: out graphql_directives.3.client.out :::
