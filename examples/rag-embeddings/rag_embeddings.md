# Generate embeddings with the default WSO2 embedding provider

An embedding provider (`ai:EmbeddingProvider`) converts text chunks into vector embeddings, so that semantically similar text can be found using vector similarity. Embeddings are the basis of retrieval-augmented generation (RAG), where they are used both when ingesting documents and when retrieving relevant chunks for a query.

This example demonstrates how to use the default WSO2 embedding provider (`ai:getDefaultEmbeddingProvider()`) to embed a document and a batch of candidate texts, and compare the similarity of each candidate with the document. To use embeddings in a knowledge base for RAG, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example. To use a specific provider with your own keys, see the [Generate embeddings with a specific provider](/learn/by-example/rag-embedding-provider/) example. To implement your own provider, see the [Implement a custom embedding provider](/learn/by-example/rag-custom-embedding-provider/) example.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. For more information on the available embedding providers, see [Embedding providers for embedding models](https://wso2.com/integration-platform/docs/genai/develop/components/embedding-providers).

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_embeddings.bal :::

::: out rag_embeddings.out :::

## Related links

- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
