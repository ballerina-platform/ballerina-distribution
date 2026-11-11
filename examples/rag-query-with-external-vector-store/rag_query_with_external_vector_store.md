# Retrieve from Pinecone

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and returns the most similar chunks from the vector store. You then add the chunks to the prompt, for example with `ai:augmentUserQuery`, and generate the answer with a model provider.

This example retrieves chunks from the [Pinecone](https://www.pinecone.io/) index that the ingestion example populated, and answers questions in two ways: with a custom prompt and the `generate` method, and with `ai:augmentUserQuery` and the `chat` method.

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
