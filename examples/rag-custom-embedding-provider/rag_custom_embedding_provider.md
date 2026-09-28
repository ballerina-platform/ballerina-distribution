# Implement a custom embedding provider

An embedding provider (`ai:EmbeddingProvider`) converts chunks into vector embeddings. Modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest) and [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) provide implementations for their services. To use an embedding model that has no provider module, such as a self-hosted model or an internal embeddings gateway, implement the `ai:EmbeddingProvider` type yourself.

An `ai:EmbeddingProvider` is a client object with two remote methods: `embed`, which converts a single chunk into an `ai:Embedding`, and `batchEmbed`, which converts a batch of chunks in one call. A custom provider can be used anywhere an embedding provider is expected, including in an `ai:VectorKnowledgeBase`, which uses it both to embed the chunks when ingesting and to embed the query when retrieving.

This example demonstrates a custom embedding provider for services that follow the OpenAI embeddings API, used with a local [Ollama](https://ollama.com) server, and plugs it into a knowledge base.

> Note: This example requires a running Ollama server with the `nomic-embed-text` model (`ollama pull nomic-embed-text`). To use another OpenAI-compatible service, set `embeddingServiceUrl` and `embeddingModel` in the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_embedding_provider.bal :::

::: out rag_custom_embedding_provider.out :::

## Related links

- [The Generate embeddings with the default WSO2 embedding provider example](/learn/by-example/rag-embeddings/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Implement a custom vector store example](/learn/by-example/rag-custom-vector-store/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
