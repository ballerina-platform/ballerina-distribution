# Retrieve from an in-memory vector store

Retrieval-augmented generation (RAG) enhances the capabilities of large language models (LLMs) by combining them with external knowledge sources to provide more accurate and contextually-relevant responses. At query time, the chunks that are most similar to the user's question are retrieved from the knowledge base and added to the prompt sent to the LLM.

This example demonstrates the retrieval and generation steps of a RAG workflow with the built-in `ai:InMemoryVectorStore`. Since an in-memory vector store is emptied when the program stops, the documents are ingested in the same program before the query. The ingestion for this example is explained in the [Ingest into an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-ingestion/) example. With an external vector store, ingestion and retrieval can run as separate programs.

> Note: This example uses the default embedding provider and model provider implementations. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_in_memory_vector_store_retrieval.bal :::

::: out rag_in_memory_vector_store_retrieval.out :::

## Related links

- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-in-memory-vector-store-retrieval/leave_policy.md)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Filter results by metadata example](/learn/by-example/rag-query-with-metadata-filters/)
- [The Retrieve from pgvector example](/learn/by-example/rag-pgvector-retrieval/)
