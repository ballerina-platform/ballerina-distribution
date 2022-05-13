# Returning service objects

A GraphQL resource function can return service objects. The returning
service objects are mapped to the `OBJECT` type in the GraphQL schema. Each
resource function in the returned service object becomes a field in the
created `OBJECT` type.<br/><br/>
For more information on the underlying package, see the
[`graphql` package](https://docs.central.ballerina.io/ballerina/graphql/latest/).

::: code ./examples/graphql-returning-service-objects/graphql_returning_service_objects.bal :::

::: out ./examples/graphql-returning-service-objects/graphql_returning_service_objects.client.out :::

::: out ./examples/graphql-returning-service-objects/graphql_returning_service_objects.server.out :::