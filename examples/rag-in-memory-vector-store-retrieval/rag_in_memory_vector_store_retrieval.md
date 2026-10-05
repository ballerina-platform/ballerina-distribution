# Retrieve from an in-memory vector store

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and returns the most similar chunks from the vector store. You then add the chunks to the prompt, for example with `ai:augmentUserQuery`, and generate the answer with a model provider.

The in-memory vector store is emptied when the program stops, so this example ingests a document first, and then retrieves the relevant chunks and generates the answer with the default model provider.

For the ingestion part, see the [Ingest into an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-ingestion/) example.

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
