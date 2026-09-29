# Retrieve from Pinecone

Retrieval-augmented generation (RAG) is a technique that enhances capabilities of large language models by combining them with external knowledge sources to provide more accurate and contextually-relevant responses.

Ballerina has high-level, provider-agnostic APIs for retrieval-augmented generation (RAG) workflows. These include abstractions such as `ai:VectorStore`, `ai:EmbeddingProvider`, and `ai:KnowledgeBase`.

These abstractions enable you to query semantically similar content from vector databases (e.g., Pinecone, Weaviate, etc.) and use retrieved context in the request to the LLM to generate more accurate responses.

This example demonstrates how to retrieve relevant chunks from a knowledge base backed by a [Pinecone](https://www.pinecone.io/) index and use them with a language model to answer questions based on the retrieved context, using both a custom prompt with the `generate` method and `ai:augmentUserQuery` with the `chat` method.

> Prerequisite: The ingestion for this example is in the [Ingest into Pinecone](/learn/by-example/rag-ingestion-with-external-vector-store/) example. Run it first. It populates the Pinecone index that this example queries.

> Note: This example uses the default model provider and embedding provider implementations and Pinecone. To generate the configuration for the model and embedding providers, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation. Follow [`ballerinax/ai.pinecone` prerequisites](https://central.ballerina.io/ballerinax/ai.pinecone/latest#prerequisites) to extract Pinecone configuration. Alternatively, you can try out the in-memory vector store (`ai:InMemoryVectorStore`).

For more information on the underlying module, see the [`ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest).

::: code rag_query_with_external_vector_store.bal :::

::: out rag_query_with_external_vector_store.out :::

## Related links

- [Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
