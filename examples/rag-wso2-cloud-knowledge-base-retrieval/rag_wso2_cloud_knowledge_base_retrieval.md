# Retrieve from a WSO2 Cloud knowledge base

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG). The [ballerinax/ai.wso2.integration](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest) module implements it with `wso2:CloudKnowledgeBase`, which retrieves from a knowledge base hosted on the [WSO2 Integration Platform](https://wso2.com/integration-platform/docs/). The platform ingests and embeds the documents, so the application only retrieves. The `ingest` and `deleteByFilter` methods are not supported yet. Initialize it with the service URL and a bearer token or OAuth2 client credentials. Optional parameters are `minSimilarityThreshold` (default `0.7`), Cohere reranking with `cohereRerankerApiKey`, `cohereRerankerModel`, and `rerankerTopN` (default `5`), and HTTP settings such as `timeout` and `retryConfig`.

This example retrieves from a WSO2 Cloud knowledge base and generates the answer with the default WSO2 model provider.

To let an agent decide when to retrieve, see the [Agentic RAG with WSO2 Cloud](/learn/by-example/agentic-rag-with-wso2-integration-knowledge-base/) example.

> Note:<br />• This example only retrieves. Before you run it, create the knowledge base and ingest your documents on the [WSO2 Integration Platform](https://wso2.com/integration-platform/docs/). For the generative AI components of the platform, including the default WSO2 model provider, see the [WSO2 Integration Platform documentation](https://wso2.com/integration-platform/docs/genai/develop/components/model-providers).<br />• Add the knowledge base URL and token to the `Config.toml` file (e.g., `knowledgeBaseUrl = "<knowledge-base-url>"`, `knowledgeBaseToken = "<token>"`), and optionally the Cohere reranker API key and model (`cohereRerankerApiKey`, `cohereRerankerModel`). This example also uses the default model provider implementation. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

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
