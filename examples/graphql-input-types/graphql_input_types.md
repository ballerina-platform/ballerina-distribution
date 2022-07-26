# Input types

GraphQL resources can have input parameters, which will be mapped to input
values in the generated GraphQL schema. Currently, the supported input types
are: `string`, `int`, `boolean`, `float`, and `enum`. Any of these types can
be an optional and/or defaultable types.

For more information on the underlying package, see the
[`graphql` package](https://docs.central.ballerina.io/ballerina/graphql/latest/).

::: code graphql_input_types.bal :::

Run the service by executing the following command.

::: out graphql_input_types.server.out :::

Invoke the service as follows.

::: out graphql_input_types.client.out :::
