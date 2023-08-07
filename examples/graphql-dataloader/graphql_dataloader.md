# GraphQL service - Dataloader

The Ballerina GraphQL module provides the capability to batch and cache data fetching from data sources using the `garaphql.dataloader` submodule. To leverage this functionality in a GraphQL service, users must register dataloaders through the `graphql:Context` object and implement the corresponding prefetch method logic and resolver logic. By using `garaphql.dataloader`, users can efficiently avoid frequent data fetching, effectively addressing the GraphQL N+1 problem.

::: code graphql_dataloader.bal :::

Run the service by executing the following command.

::: out graphql_dataloader.server.out :::

Send the following document to the GraphQL endpoint to test the service.

::: code graphql_dataloader.graphql :::

To send the document, execute the following cURL command in a separate terminal.

::: out graphql_dataloader.client.out :::

## Related links
- [`garaphql.dataloader` module - API documentation](https://lib.ballerina.io/ballerina/graphql.dataloader/latest)
- [The `BatchLoadFunction` - Specification](/spec/graphql/#106211-the-batchloadfunction)
- [DataLoader API - Specification](/spec/graphql/#1061-dataloader-api)
- [The DefaultDataLoade - Specification](/spec/graphql/#1062-the-defaultdataloader)
- [Engaging DataLoaders - Specification](/spec/graphql/#1063-engaging-dataloaders)
- [The `prefetch` Method - Specification](/spec/graphql/#10633-define-the-corresponding-prefetch-method)
- [Utilizing Multiple DataLoaders in a GraphQL Service](/spec/graphql/#example-utilizing-multiple-dataloaders-in-a-graphql-service)
