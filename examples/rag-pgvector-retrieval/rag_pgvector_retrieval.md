# Retrieve from pgvector

Once documents are ingested into an external vector store, any program can retrieve from it. The retrieval side of a retrieval-augmented generation (RAG) workflow connects to the same store, embeds the user's question with the same embedding provider that was used for ingestion, retrieves the most similar chunks, and augments the prompt sent to the LLM with them.

This example demonstrates retrieving from [pgvector](https://github.com/pgvector/pgvector) via the [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module and generating an answer grounded in the retrieved chunks.

> Prerequisite: The ingestion for this example is in the [Ingest into pgvector](/learn/by-example/rag-pgvector-ingestion/) example. Run it first. It populates the table that this example queries.

> Note: Add the database configuration to the `Config.toml` file (e.g., `pgPassword = "<password>"`). This example also uses the default embedding provider and model provider implementations. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_pgvector_retrieval.bal :::

::: out rag_pgvector_retrieval.out :::

## Related links

- [The Ingest into pgvector example](/learn/by-example/rag-pgvector-ingestion/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Filter results by metadata example](/learn/by-example/rag-query-with-metadata-filters/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
