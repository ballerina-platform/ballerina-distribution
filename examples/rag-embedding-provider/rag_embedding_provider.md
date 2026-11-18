# Generate embeddings with a specific provider

An embedding is a vector that represents the meaning of a text, so that texts with a similar meaning have similar embeddings. An embedding provider creates these embeddings. Instead of the default embedding provider, you can use a specific embedding provider, such as OpenAI, with your own API key.

This example creates an OpenAI embedding provider with your own API key, embeds a document and a batch of texts, and compares each text with the document.

To use embeddings in a knowledge base, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

> Note: Add the API key to the `Config.toml` file (e.g., `openAiApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest).

::: code rag_embedding_provider.bal :::

::: out rag_embedding_provider.out :::

## Related links

- [The Generate embeddings with the default WSO2 embedding provider example](/learn/by-example/rag-embeddings/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
