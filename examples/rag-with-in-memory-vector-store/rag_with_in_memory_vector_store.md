# Retrieval-augmented generation (RAG) ingestion

Ballerina has high-level, provider-agnostic APIs to ingest data for retrieval-augmented generation (RAG) workflows. These include abstractions such as `ai:DataLoader`, `ai:VectorStore`, `ai:EmbeddingProvider`, and `ai:KnowledgeBase`.

These abstractions enable you to load documents, convert them into semantically meaningful vector representations using embedding models, and index them into a vector database. Then at generation/querying, you can query semantically similar content from vector databases and use retrieved context in the request to the LLM to generate more accurate responses. The knowledge base (`ai: KnowledgeBase`) orchestrates this process.

This example demonstrates implementing RAG workflow using an in-memory vector store.

> Note: This example uses the default embedding provider and model provider implementations. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_in_memory_vector_store.bal :::

::: out rag_with_in_memory_vector_store.out :::

## Related links

- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-with-in-memory-vector-store/leave_policy.md)
- [RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [RAG query with external vector store example](/learn/by-example/rag-query-with-external-vector-store/)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)

