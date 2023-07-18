# GraphQL service - GraphiQL client

The Ballerina `graphql` module includes a built-in GraphiQL client. To enable the GraphiQL client, use the `graphiql` field in the `graphql:ServiceConfig` annotation on a `graphql:Service`. The GraphiQL client can be used to test the GraphQL APIs using the GraphiQL IDE.

This example shows how to enable the GraphiQL client for a Ballerina GraphQL service.

::: code graphql_graphiql.bal :::

Run the service by executing the following command.

::: out graphql_graphiql.out :::

To access the GraphiQL client, open a browser and access `http://localhost:9090/testing`. Following is a sample screenshot of the GraphiQL client.

![GraphiQL client](/learn/by-example/images/graphiql-client.png "GraphiQL Client")

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ServiceConfig)
- [`graphql:GraphiQL` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#Graphiql)
- [GraphQL GraphiQL client - Specification](/spec/graphql/#91-graphiql-client)
- [GraphQL GraphiQL client configuration - Specification](/spec/graphql/#715-graphiql-configurations)
