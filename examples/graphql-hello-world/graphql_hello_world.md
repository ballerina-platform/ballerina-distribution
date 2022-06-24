# Hello world

A GraphQL service in Ballerina represents a GraphQL schema. Each resource function of the `graphql:Service`
represents a resolver function in the root `Query` type. The return type of each resource function will be the
type of each field represented by the resource function.<br/><br/>
For more information on the underlying package, see the
[GraphQL package](https://docs.central.ballerina.io/ballerina/graphql/latest/).<br/><br/>
This example shows a simple GraphQL endpoint that has a single field in the root Query type, which returns a string.

::: code graphql_hello_world.bal :::

::: out graphql_hello_world.client.out :::

::: out graphql_hello_world.server.out :::