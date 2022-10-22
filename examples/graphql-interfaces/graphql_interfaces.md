# Interfaces

A GraphQL schema can have interfaces that can be implemented using other interfaces or objects. 

In Ballerina, interfaces are defined as `distinct` `service` objects, and the fields of the interfaces are defined as resource function definitions. Objects that are implementing the interfaces must implement the `resource` methods defined in the service objects.
The Ballerina type inclusion is used to include the interface type to another interface type or an object type.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_interfaces.bal :::

Run the service by executing the following command.

::: out graphql_interfaces.server.out :::

Invoke the service as follows.

::: out graphql_interfaces.client.out :::
