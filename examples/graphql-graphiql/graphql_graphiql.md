# GraphQL service - GraphiQL client

The Ballerina GraphQL includes a built-in GraphiQL client for testing the GraphQL endpoint. To enable the GraphiQL client, you can use the `graphql:ServiceConfig` annotation on a GraphQL service. There is a field named `graphiql` in the `graphql:ServiceConfig`, where you can enable/disable the GraphiQL client and provide a path to the GraphiQL client.

This example shows how to enable the GraphiQL client for a Ballerina GraphQL service.

::: code graphql_graphiql.bal :::

Run the service by executing the following command.

::: out graphql_graphiql.out :::

To access the GraphiQL client, open a browser and access `http://localhost:9090/testing`. Following is a sample screenshot of the GraphiQL client.

![GraphiQL client](/learn/by-example/images/graphiql-client.png "GraphiQL Client")

## Related Links
- [`graphql` - API documentation](https://lib.ballerina.io/ballerina/graphql/latest).
- [`graphql` GraphiQL - Specification](/spec/graphql/#121-graphiql-client).
