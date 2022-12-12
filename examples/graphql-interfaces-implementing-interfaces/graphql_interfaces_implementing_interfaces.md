# GraphQL service - Interfaces implementing interfaces

The Ballerina GraphQL service allows to define GraphQL interface types, that can implement other interfaces. A `distinct` `service` object must be used to define an interface. The Ballerina type-inclusion is used to define interfaces that implement other interfaces. This can be used in GraphQL schemas to define higher-order interfaces that share common functionalities in the application logic.

This example shows how to define interfaces that implement other interfaces in Ballerina.

::: code graphql_interfaces_implementing_interfaces.bal :::

Run the service by executing the following command.

::: out graphql_interfaces_implementing_interfaces.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interfaces_implementing_interfaces.graphql :::

To send the document, use the following cURL command in a separate terminal.

::: out graphql_interfaces_implementing_interfaces.client.out :::

>**Tip:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client-query-endpoint/).

## Related links
- [`graphql` package - API documentation](https://lib.ballerina.io/ballerina/graphql/latest)
- [GraphQL interfaces implementing interfaces - Specification](/spec/graphql/#461-interfaces-implementing-interfaces)
