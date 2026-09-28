# Ingest into pgvector

Ballerina provides the `ai:VectorStore` abstraction for persisting and searching vector embeddings, with implementations for external vector databases such as pgvector, Pinecone, Milvus, and Weaviate, in addition to the built-in `ai:InMemoryVectorStore`. Since all implementations share the same type, the vector store can be swapped without changing the rest of the retrieval-augmented generation (RAG) workflow. With an external vector store, the ingested data persists, so ingestion and retrieval can run as separate programs.

This example demonstrates ingesting documents into [pgvector](https://github.com/pgvector/pgvector), a PostgreSQL extension for vector similarity search, via the [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) module. It covers ingestion only. For the query part, see the [Retrieve from pgvector](/learn/by-example/rag-pgvector-retrieval/) example.

> Note: This example requires a running PostgreSQL instance with the pgvector extension available. For example, start one with Docker using `docker run --name pgvector-db -e POSTGRES_PASSWORD=<password> -e POSTGRES_DB=vector_db -p 5432:5432 -d pgvector/pgvector:pg17`. Add the database configuration to the `Config.toml` file (e.g., `pgPassword = "<password>"`). This example also uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_pgvector_ingestion.bal :::

::: out rag_pgvector_ingestion.out :::

## Related links

- [The Retrieve from pgvector example](/learn/by-example/rag-pgvector-retrieval/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.pgvector` module](https://central.ballerina.io/ballerinax/ai.pgvector/latest)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
