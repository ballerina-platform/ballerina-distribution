# Retrieve from Azure AI Search

Once documents are ingested into an Azure AI Search index, any program can retrieve from it by creating an `azure:AiSearchKnowledgeBase` for the existing index. The retrieval side of a retrieval-augmented generation (RAG) workflow embeds the user's question with the same embedding provider that was used for ingestion, retrieves the most similar chunks with vector search, and augments the prompt sent to the LLM with them.

This example demonstrates retrieving from an existing index via the [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) module and generating an answer with Azure OpenAI.

> Prerequisite: The ingestion for this example is in the [Ingest into Azure AI Search](/learn/by-example/rag-azure-ai-search-ingestion/) example. Run it first. It creates and populates the `hr-policies` index that this example queries.

> Note: Add the Azure AI Search and Azure OpenAI values to the `Config.toml` file (e.g., `searchServiceUrl = "https://<service>.search.windows.net"`, `searchApiKey = "<admin-key>"`, `openAiServiceUrl = "https://<resource>.services.ai.azure.com/openai/v1"`, `openAiApiKey = "<api-key>"`, `chatDeploymentId = "<deployment>"`, `embeddingDeploymentId = "<deployment>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_azure_ai_search_retrieval.bal :::

::: out rag_azure_ai_search_retrieval.out :::

## Related links

- [The Ingest into Azure AI Search example](/learn/by-example/rag-azure-ai-search-ingestion/)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/azure.ai.search` module](https://central.ballerina.io/ballerinax/azure.ai.search/latest)
