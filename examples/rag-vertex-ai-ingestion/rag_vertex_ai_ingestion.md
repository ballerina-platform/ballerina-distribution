# Ingest with Google Vertex AI embeddings

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store.

This example embeds the chunks with a [Google Vertex AI](https://cloud.google.com/vertex-ai) embedding model through the [ballerinax/ai.googleapis.vertex](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest) module, and stores them in the in-memory vector store, which you can replace with any `ai:VectorStore` implementation.

For the query part, see the [Retrieve and generate with Google Vertex AI](/learn/by-example/rag-vertex-ai-retrieval/) example.

> Note: Create a Google Cloud service account with access to Vertex AI, download its JSON key file, and add the path, the project ID, and the location to the `Config.toml` file (e.g., `serviceAccountKeyPath = "/path/to/key.json"`, `projectId = "<gcp-project-id>"`, `location = "us-central1"`). Never commit credentials to source control.

For more information on the underlying module, see the [`ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest).

::: code rag_vertex_ai_ingestion.bal :::

::: out rag_vertex_ai_ingestion.out :::

## Related links

- [The Retrieve and generate with Google Vertex AI example](/learn/by-example/rag-vertex-ai-retrieval/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Ingest with OpenRouter embeddings example](/learn/by-example/rag-openrouter-ingestion/)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
