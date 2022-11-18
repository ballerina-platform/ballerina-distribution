# Interfaces

A GraphQL schema can have interfaces. In Ballerina, interfaces are defined using `distinct` `service` objects and the fields of the interfaces are defined as resource function definitions. Objects that are implementing the interfaces must implement the `resource` methods defined in the service objects. The Ballerina type inclusion is used to include the interface type to an object type.

This example shows how to define an interface `Animal` and then implement the `Leopard` and `Elephant` classes using that interface.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_interfaces.bal :::

Run the service by executing the following command.

::: out graphql_interfaces.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interfaces.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_interfaces.client.out :::
