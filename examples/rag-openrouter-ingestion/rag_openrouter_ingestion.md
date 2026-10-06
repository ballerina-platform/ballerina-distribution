# Ingest with OpenRouter embeddings

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store.

This example embeds the chunks with an embedding model on [OpenRouter](https://openrouter.ai/) (`openai/text-embedding-3-small`) through the [ballerinax/ai.openrouter](https://central.ballerina.io/ballerinax/ai.openrouter/latest) module, and stores them in the in-memory vector store, which you can replace with any `ai:VectorStore` implementation.

For the query part, see the [Retrieve and generate with OpenRouter](/learn/by-example/rag-openrouter-retrieval/) example.

> Note: Add the OpenRouter API key to the `Config.toml` file (e.g., `openRouterApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest).

::: code rag_openrouter_ingestion.bal :::

::: out rag_openrouter_ingestion.out :::

## Related links

- [The Retrieve and generate with OpenRouter example](/learn/by-example/rag-openrouter-retrieval/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Ingest with Google Vertex AI embeddings example](/learn/by-example/rag-vertex-ai-ingestion/)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
