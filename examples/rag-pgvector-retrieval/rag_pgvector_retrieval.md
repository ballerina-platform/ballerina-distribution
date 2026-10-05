# Retrieve from pgvector

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and returns the most similar chunks from the vector store. You then add the chunks to the prompt, for example with `ai:augmentUserQuery`, and generate the answer with a model provider.

This example retrieves chunks from the [pgvector](https://github.com/pgvector/pgvector) table that the ingestion example populated, through the [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module, and generates the answer with the default model provider.

> Prerequisite: The ingestion for this example is in the [Ingest into pgvector](/learn/by-example/rag-pgvector-ingestion/) example. Run it first. It populates the table that this example queries.

> Note: Add the database configuration to the `Config.toml` file (e.g., `pgPassword = "<password>"`). This example also uses the default embedding provider and model provider implementations. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest).

::: code rag_pgvector_retrieval.bal :::

::: out rag_pgvector_retrieval.out :::

## Related links

- [The Ingest into pgvector example](/learn/by-example/rag-pgvector-ingestion/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Filter results by metadata example](/learn/by-example/rag-query-with-metadata-filters/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
