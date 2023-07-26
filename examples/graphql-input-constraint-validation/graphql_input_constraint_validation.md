# GraphQL service - Input constraint validation

GraphQL input constraint validation allows you to define and enforce constraints on input arguments. These constraints ensure that the provided input values meet certain criteria before they are processed. The input constraints can be configured using the `@constraint` annotation provided by the Ballerina constraint package. The constraint validation can be enabled or disabled using the `validation` field in the `graphql:ServiceConfig`. By default, the validation field is set to `true`.

::: code graphql_input_constraint_validation.bal :::

Run the service by executing the following command.

::: out graphql_input_constraint_validation.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_input_constraint_validation.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_input_constraint_validation.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [Constraint annotation - API documentation](https://lib.ballerina.io/ballerina/constraint/latest#Annotations)
- [GraphQL constraint config - Specification](/spec/graphql/#1018-constraint-configurations)
- [`constraint` module - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
