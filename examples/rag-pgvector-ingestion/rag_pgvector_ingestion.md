# Ingest into pgvector

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store.

This example ingests documents into a PostgreSQL table with the [pgvector](https://github.com/pgvector/pgvector) extension through the [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module, with the default embedding provider. The vectors are kept in the database, so a separate program can retrieve them.

For the query part, see the [Retrieve from pgvector](/learn/by-example/rag-pgvector-retrieval/) example.

> Note: This example requires a running PostgreSQL instance with the pgvector extension available. For example, start one with Docker using `docker run --name pgvector-db -e POSTGRES_PASSWORD=<password> -e POSTGRES_DB=vector_db -p 5432:5432 -d pgvector/pgvector:pg17`. Add the database configuration to the `Config.toml` file (e.g., `pgPassword = "<password>"`). This example also uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest).

::: code rag_pgvector_ingestion.bal :::

::: out rag_pgvector_ingestion.out :::

## Related links

- [The Retrieve from pgvector example](/learn/by-example/rag-pgvector-retrieval/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
