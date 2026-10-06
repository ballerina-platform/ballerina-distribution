# Implement a custom embedding provider

If you need an embedding provider with your own logic, for example to call a self-hosted model or an internal embeddings service, or to change how the embeddings are created, implement the `ai:EmbeddingProvider` type yourself. Implement its two remote methods: `embed` to create the embedding of one chunk, and `batchEmbed` to create the embeddings of many chunks in one call. You can then use your provider anywhere an embedding provider is expected, such as in a knowledge base.

This example implements a provider for services that follow the OpenAI embeddings API, uses it with a local [Ollama](https://ollama.com) server, and plugs it into a knowledge base.

> Note: This example requires a running Ollama server with the `nomic-embed-text` model (`ollama pull nomic-embed-text`). To use another OpenAI-compatible service, set `embeddingServiceUrl` and `embeddingModel` in the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_embedding_provider.bal :::

::: out rag_custom_embedding_provider.out :::

## Related links

- [The Generate embeddings with the default WSO2 embedding provider example](/learn/by-example/rag-embeddings/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Implement a custom vector store example](/learn/by-example/rag-custom-vector-store/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
