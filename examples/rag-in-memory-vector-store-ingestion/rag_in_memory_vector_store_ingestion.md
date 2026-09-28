# Ingest into an in-memory vector store

Ballerina has high-level, provider-agnostic APIs to ingest data for retrieval-augmented generation (RAG) workflows. These include abstractions such as `ai:DataLoader`, `ai:VectorStore`, `ai:EmbeddingProvider`, and `ai:KnowledgeBase`. The knowledge base (`ai:KnowledgeBase`) orchestrates the ingestion: it chunks the documents, embeds the chunks, and stores the vectors in the vector store.

The built-in `ai:InMemoryVectorStore` keeps the vectors in the memory of the running program. It needs no external service, which makes it the quickest way to try out RAG, but the stored vectors are lost when the program stops, so ingestion and retrieval must happen in the same program. For this reason, the retrieval example ingests the same document again before querying.

This example demonstrates how to load a Markdown document and ingest it into an in-memory vector store. It covers ingestion only. For the query part, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_in_memory_vector_store_ingestion.bal :::

::: out rag_in_memory_vector_store_ingestion.out :::

## Related links

- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-in-memory-vector-store-ingestion/leave_policy.md)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
