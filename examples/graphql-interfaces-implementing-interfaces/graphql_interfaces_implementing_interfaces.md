# Interfaces implementing interfaces

A GraphQL schema can have interfaces that can be implemented using other interfaces.

In Ballerina, interfaces are defined as `distinct` `service` objects. The Ballerina type inclusion is used to include the interface type to another interface type.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_interfaces_implementing_interfaces.bal :::

Run the service by executing the following command.

::: out graphql_interfaces_implementing_interfaces.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_interfaces_implementing_interfaces.graphql :::

To send the document, use the following cURL command in a separate terminal.

>**Info:** You can invoke the above service via the [GraphQL client](/learn/by-example/graphql-client/).

::: out graphql_interfaces_implementing_interfaces.client.out :::
