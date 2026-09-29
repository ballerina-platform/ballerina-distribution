# Ingest into Azure AI Search

In addition to the vector store-based `ai:VectorKnowledgeBase`, Ballerina provides knowledge bases backed by managed search services. The [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) module provides `azure:AiSearchKnowledgeBase`, an `ai:KnowledgeBase` implementation backed by [Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/ai-search), which stores the chunks and their embeddings in a search index and retrieves them with vector search.

The knowledge base can be created for a new index by passing a `search:SearchIndex` definition, which creates the index, or for an existing index by passing the index name. The index must have a key field of type string, a content field (named `content` by default), and a vector field whose dimension matches the embedding model.

This example demonstrates creating a knowledge base with a new index definition and ingesting documents into it, using Azure OpenAI for the embeddings. It covers ingestion only. For the query part, see the [Retrieve from Azure AI Search](/learn/by-example/rag-azure-ai-search-retrieval/) example.

> Note: Create an [Azure AI Search](https://learn.microsoft.com/en-us/azure/search/search-create-service-portal) service and an Azure OpenAI resource with an embedding deployment, and add the values to the `Config.toml` file (e.g., `searchServiceUrl = "https://<service>.search.windows.net"`, `searchApiKey = "<admin-key>"`, `openAiServiceUrl = "https://<resource>.services.ai.azure.com/openai/v1"`, `openAiApiKey = "<api-key>"`, `embeddingDeploymentId = "<deployment>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_azure_ai_search_ingestion.bal :::

::: out rag_azure_ai_search_ingestion.out :::

## Related links

- [The Retrieve from Azure AI Search example](/learn/by-example/rag-azure-ai-search-retrieval/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/azure.ai.search` module](https://central.ballerina.io/ballerinax/azure.ai.search/latest)
