# Directives

The Ballerina GraphQL supports the following graphql directives.

`@depricated` - Marks the schema definition of a field or enum value as deprecated with an optional reason.
`@skip(if: Boolean!)` -  	If true, the decorated field or fragment in an operation is not resolved by the GraphQL server.
`@include(if: Boolean!)` - If false, the decorated field or fragment in an operation is not resolved by the GraphQL server.

The following example demonstrates the use of graphql directives

::: code directives.bal :::

Run the service by executing the following command.

::: out graphql_directives.server.out :::

Following requests demonstrate the usage of `@skip` and `@include` directives
Invoke the service using the following curl command to inspect the result.

::: out graphql_directives.client.out :::