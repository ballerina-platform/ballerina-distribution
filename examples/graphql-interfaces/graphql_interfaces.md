# GraphQL service - Interfaces

The Ballerina GraphQL module allows defining GraphQL interface types. An interface specifies a set of fields that multiple object types can include. In Ballerina, interfaces are defined using `distinct` `service` objects, and the fields of the interfaces are defined as resource method definitions. Objects that are implementing the interfaces must implement the `resource` methods defined in the `service` objects. The Ballerina type inclusion includes the interface type to an object type. Use an interface to return a type that consists of a set of possible types with common fields.

::: code graphql_interfaces.bal :::

Run the service by executing the following command.

::: out graphql_interfaces.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interfaces.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_interfaces.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` module - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL interfaces - Specification](/spec/graphql/#46-interfaces)
