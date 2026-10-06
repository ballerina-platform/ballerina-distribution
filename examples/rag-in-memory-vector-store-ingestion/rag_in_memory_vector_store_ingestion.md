# Ingest into an in-memory vector store

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store.

This example loads a Markdown document and ingests it into the built-in `ai:InMemoryVectorStore` with the default embedding provider. The in-memory vector store needs no external service, but it loses the vectors when the program stops.

For the query part, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

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
