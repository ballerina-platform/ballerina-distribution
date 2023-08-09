# GraphQL service - Dataloader

The Ballerina GraphQL module provides the capability to batch and cache data fetching from data sources using the `graphql.dataloader` submodule. To leverage this functionality in a GraphQL service, you must register data loaders through the `graphql:Context` object and implement the corresponding prefetch method logic and resolver method logic. 

A prefetch method, in the context of Ballerina GraphQL, is a method that is invoked before the actual resolver method. By default, the prefetch method name follows the convention of having the prefix `pre`, followed by the resolver method name. The use of `graphql.dataloader` avoids excessive data fetching, effectively addressing the GraphQL N+1 problem.

::: code graphql_dataloader.bal :::

Run the service by executing the following command.

::: out graphql_dataloader.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_dataloader.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_dataloader.client.out :::

## Related links
- [`garaphql.dataloader` module - API documentation](https://lib.ballerina.io/ballerina/graphql.dataloader/latest)
- [DataLoader - Specification](/spec/graphql/#106-dataloader)
- [Utilizing multiple dataloaders in a graphql service](/spec/graphql/#example-utilizing-multiple-dataloaders-in-a-graphql-service)
