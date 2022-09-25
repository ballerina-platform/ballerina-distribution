# Client

The GraphQL Client Connector can be used to connect and interact with a GraphQL server.

::: code graphql_client.bal :::

Further, the execute method optionally takes a map of variables and an operationName in case the document contains any variables or contains more than one operation. For more information on the underlying package, see the [`graphql` package](https://lib.ballerina.io/ballerina/graphql/latest/).

As the prerequisites to run the client program execute server program given in [Returning record values example](https://ballerina.io/learn/by-example/graphql-returning-record-values).
Run the client program by executing the following command. 

::: out graphql_client.out :::