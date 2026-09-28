# Ingest with OpenRouter embeddings

[OpenRouter](https://openrouter.ai/) provides unified access to large language models (LLMs) and embedding models from many providers through a single API and key. The [ballerinax/ai.openrouter](https://central.ballerina.io/ballerinax/ai.openrouter/latest) module provides `ai:ModelProvider` and `ai:EmbeddingProvider` implementations for OpenRouter, so any model available on OpenRouter can be used in a retrieval-augmented generation (RAG) workflow by specifying its identifier (e.g., `openai/text-embedding-3-small`).

This example demonstrates the ingestion side of a RAG workflow in which the chunks are embedded through OpenRouter. The example stores the vectors in the in-memory vector store; any `ai:VectorStore` implementation can be used instead to persist them. It covers ingestion only. For the query part, where the chunks are retrieved and an OpenRouter-hosted model generates the answer, see the [Retrieve and generate with OpenRouter](/learn/by-example/rag-openrouter-retrieval/) example.

> Note: Add the OpenRouter API key to the `Config.toml` file (e.g., `openRouterApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_openrouter_ingestion.bal :::

::: out rag_openrouter_ingestion.out :::

## Related links

- [The Retrieve and generate with OpenRouter example](/learn/by-example/rag-openrouter-retrieval/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Ingest with Google Vertex AI embeddings example](/learn/by-example/rag-vertex-ai-ingestion/)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
