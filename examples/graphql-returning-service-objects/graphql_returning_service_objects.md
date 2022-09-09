# Returning service objects

A GraphQL resource function can return service objects. The returning service objects are mapped to the `OBJECT` type in the GraphQL schema. Each resource function in the returned service object becomes a field in the created `OBJECT` type.

For more information on the underlying package, see the [GraphQL package](https://lib.ballerina.io/ballerina/graphql/latest/).

::: code graphql_returning_service_objects.bal :::

Run the service by executing the following command.

::: out graphql_returning_service_objects.server.out :::

Invoke the service as follows.

::: out graphql_returning_service_objects.client.out :::