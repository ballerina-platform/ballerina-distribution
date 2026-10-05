# Retrieve from Azure AI Search

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG). The [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) module implements it with `azure:AiSearchKnowledgeBase`, which works with an [Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/ai-search) index. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and finds the most similar chunks in the index with vector search.

This example retrieves chunks from an existing index, adds them to the prompt with `ai:augmentUserQuery`, and generates the answer with Azure OpenAI.

> Prerequisite: The ingestion for this example is in the [Ingest into Azure AI Search](/learn/by-example/rag-azure-ai-search-ingestion/) example. Run it first. It creates and populates the `hr-policies` index that this example queries.

> Note: Add the Azure AI Search and Azure OpenAI values to the `Config.toml` file (e.g., `searchServiceUrl = "https://<service>.search.windows.net"`, `searchApiKey = "<admin-key>"`, `openAiServiceUrl = "https://<resource>.services.ai.azure.com/openai/v1"`, `openAiApiKey = "<api-key>"`, `chatDeploymentId = "<deployment>"`, `embeddingDeploymentId = "<deployment>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_azure_ai_search_retrieval.bal :::

::: out rag_azure_ai_search_retrieval.out :::

## Related links

- [The Ingest into Azure AI Search example](/learn/by-example/rag-azure-ai-search-ingestion/)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/azure.ai.search` module](https://central.ballerina.io/ballerinax/azure.ai.search/latest)
