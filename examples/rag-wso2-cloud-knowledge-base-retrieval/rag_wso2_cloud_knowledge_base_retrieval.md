# Retrieve from a WSO2 Cloud knowledge base

The [ballerinax/ai.wso2.integration](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest) module provides `wso2:CloudKnowledgeBase`, an `ai:KnowledgeBase` implementation backed by a knowledge base hosted on the [WSO2 Integration Platform](https://wso2.com/integration-platform/docs/). The documents are ingested, chunked, and embedded on the platform, so the application only retrieves from it: the query is embedded by the platform and the matching chunks are returned with their similarity scores. The `ingest` and `deleteByFilter` methods are not supported yet.

When initializing the knowledge base, provide the service URL and the authentication configuration, which accepts a bearer token or OAuth2 client credentials. The optional parameters configure the retrieval: `minSimilarityThreshold` drops the chunks that score below it (the default is `0.7`), and `cohereRerankerApiKey`, `cohereRerankerModel`, and `rerankerTopN` rerank the retrieved chunks with Cohere and keep the top N of them (the default is `5`). Reranking is disabled when no API key is provided. The remaining parameters are HTTP connection configurations, such as `timeout` and `retryConfig`. Since it implements `ai:KnowledgeBase`, the retrieved chunks are used exactly like those from any other knowledge base: augment the prompt with them and generate the answer with a model provider.

This example demonstrates retrieving from a WSO2 Cloud knowledge base and generating the answer with the default WSO2 model provider. To let an agent decide when to retrieve, see the [Agentic RAG with WSO2 Cloud](/learn/by-example/agentic-rag-with-wso2-integration-knowledge-base/) example.

> Note:
> - This example only retrieves. Before you run it, create the knowledge base and ingest your documents on the [WSO2 Integration Platform](https://wso2.com/integration-platform/docs/). For the generative AI components of the platform, including the default WSO2 model provider, see the [WSO2 Integration Platform documentation](https://wso2.com/integration-platform/docs/genai/develop/components/model-providers).
> - Add the knowledge base URL and token to the `Config.toml` file (e.g., `knowledgeBaseUrl = "<knowledge-base-url>"`, `knowledgeBaseToken = "<token>"`), and optionally the Cohere reranker API key and model (`cohereRerankerApiKey`, `cohereRerankerModel`). This example also uses the default model provider implementation. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest).

::: code rag_wso2_cloud_knowledge_base_retrieval.bal :::

::: out rag_wso2_cloud_knowledge_base_retrieval.out :::

## Related links

- [The Agentic RAG with WSO2 Cloud example](/learn/by-example/agentic-rag-with-wso2-integration-knowledge-base/)
- [The Retrieve from Azure AI Search example](/learn/by-example/rag-azure-ai-search-retrieval/)
- [The Augment the prompt with retrieved context example](/learn/by-example/rag-augment-prompt/)
- [The `ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest)
- [WSO2 Integration Platform documentation](https://wso2.com/integration-platform/docs/)
- [WSO2 Integration Platform: Model providers](https://wso2.com/integration-platform/docs/genai/develop/components/model-providers)
