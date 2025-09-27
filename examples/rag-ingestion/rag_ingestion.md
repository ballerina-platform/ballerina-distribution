# Data ingestion for retrieval-augmented generation (RAG)

Ballerina has high-level, provider-agnostic APIs to ingest data for retrieval-augmented generation (RAG) workflows. These include abstractions such as `ai:DataLoader`, `ai:VectorStore`, `ai:EmbeddingProvider`, and `ai:KnowledgeBase`.

These abstractions enable you to load documents, convert them into semantically meaningful vector representations using embedding models, and index them into a vector database (e.g., Pinecone, Weaviate, etc.). The knowledge base orchestrates this process.

This example demonstrates how to use `ai:TextDataLoader` to load documents, generate embeddings with a configured provider, and ingest them into a vector store.

> Note: This example uses the default embedding provider implementation and Pinecone. Log in to the Ballerina Copilot, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your keys to the `Config.toml` file. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation. Follow [`ballerinax/ai.pinecone` prerequisites](https://central.ballerina.io/ballerinax/ai.pinecone/latest#prerequisites) to extract Pinecone configuration. Alternatively, you can try out the in-memory vector store (`ai:InMemoryVectorStore`).

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_ingestion.bal :::

::: out rag_ingestion.out :::

## Related links

- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-ingestion/leave_policy.pdf)
- [RAG query example](/learn/by-example/rag-query/)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)

