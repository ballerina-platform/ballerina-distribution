# Ingest into Pinecone

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store.

This example loads a PDF document and ingests it into a [Pinecone](https://www.pinecone.io/) index through the [ballerinax/ai.pinecone](https://central.ballerina.io/ballerinax/ai.pinecone/latest) module, with the default embedding provider.

For the query part, see the [Retrieve from Pinecone](/learn/by-example/rag-query-with-external-vector-store/) example.

> Note: This example uses the default embedding provider implementation and Pinecone. To generate the configuration for the embedding provider, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation. Follow [`ballerinax/ai.pinecone` prerequisites](https://central.ballerina.io/ballerinax/ai.pinecone/latest#prerequisites) to extract Pinecone configuration. Alternatively, you can try out the in-memory vector store (`ai:InMemoryVectorStore`).

For more information on the underlying module, see the [`ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest).

::: code rag_ingestion_with_external_vector_store.bal :::

::: out rag_ingestion_with_external_vector_store.out :::

## Related links

- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-ingestion-with-external-vector-store/leave_policy.pdf)
- [Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)

