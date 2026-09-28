# Vector store operations

A vector store (`ai:VectorStore`) persists vector entries and searches them by similarity. Each entry (`ai:VectorEntry`) pairs a chunk with its embedding and can carry an ID and metadata. The store exposes three operations: `add` to store entries, `query` to search by an embedding, optionally combined with metadata filters, and `delete` to remove entries by ID.

In a retrieval-augmented generation (RAG) workflow, the knowledge base (`ai:VectorKnowledgeBase`) drives these operations for you. Using the store directly is useful to understand what happens underneath, to index vectors produced elsewhere, or to manage entries individually. Ballerina provides the built-in `ai:InMemoryVectorStore` and implementations for external databases such as pgvector, Pinecone, Milvus, and Weaviate, which all share the same `ai:VectorStore` type.

This example demonstrates adding entries with IDs and metadata to an in-memory vector store, querying by similarity with and without metadata filters, and deleting an entry.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_vector_store_operations.bal :::

::: out rag_vector_store_operations.out :::

## Related links

- [The Generate embeddings with the default WSO2 embedding provider example](/learn/by-example/rag-embeddings/)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The Filter results by metadata example](/learn/by-example/rag-query-with-metadata-filters/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
