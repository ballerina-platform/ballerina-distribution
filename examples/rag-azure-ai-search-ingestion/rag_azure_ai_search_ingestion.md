# Ingest into Azure AI Search

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG). The [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) module implements it with `azure:AiSearchKnowledgeBase`, which stores the chunks and their embeddings in an [Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/ai-search) index. Pass a `search:SearchIndex` definition to create the index, or the name of an existing index.

This example creates an index and ingests documents into it, and then ingests another document into the same index by connecting to it as an existing index. It uses Azure OpenAI for the embeddings.

For the query part, see the [Retrieve from Azure AI Search](/learn/by-example/rag-azure-ai-search-retrieval/) example.

> Note: Create an [Azure AI Search](https://learn.microsoft.com/en-us/azure/search/search-create-service-portal) service and an Azure OpenAI resource with an embedding deployment, and add the values to the `Config.toml` file (e.g., `searchServiceUrl = "https://<service>.search.windows.net"`, `searchApiKey = "<admin-key>"`, `openAiServiceUrl = "https://<resource>.services.ai.azure.com/openai/v1"`, `openAiApiKey = "<api-key>"`, `embeddingDeploymentId = "<deployment>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_azure_ai_search_ingestion.bal :::

::: out rag_azure_ai_search_ingestion.out :::

## Related links

- [The Retrieve from Azure AI Search example](/learn/by-example/rag-azure-ai-search-retrieval/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/azure.ai.search` module](https://central.ballerina.io/ballerinax/azure.ai.search/latest)
