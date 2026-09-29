# Ingest with Google Vertex AI embeddings

[Google Vertex AI](https://cloud.google.com/vertex-ai) provides access to Gemini and partner models as well as embedding models on Google Cloud. The [ballerinax/ai.googleapis.vertex](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest) module provides `ai:ModelProvider` and `ai:EmbeddingProvider` implementations for Vertex AI, authenticating with a service account key file, service account credentials, or OAuth2 refresh tokens.

This example demonstrates the ingestion side of a retrieval-augmented generation (RAG) workflow in which the chunks are embedded with a Vertex AI embedding model. The example stores the vectors in the in-memory vector store; any `ai:VectorStore` implementation can be used instead to persist them. It covers ingestion only. For the query part, where the chunks are retrieved and a Gemini model generates the answer, see the [Retrieve and generate with Google Vertex AI](/learn/by-example/rag-vertex-ai-retrieval/) example.

> Note: Create a Google Cloud service account with access to Vertex AI, download its JSON key file, and add the path, the project ID, and the location to the `Config.toml` file (e.g., `serviceAccountKeyPath = "/path/to/key.json"`, `projectId = "<gcp-project-id>"`, `location = "us-central1"`). Never commit credentials to source control.

For more information on the underlying module, see the [`ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest).

::: code rag_vertex_ai_ingestion.bal :::

::: out rag_vertex_ai_ingestion.out :::

## Related links

- [The Retrieve and generate with Google Vertex AI example](/learn/by-example/rag-vertex-ai-retrieval/)
- [The Generate embeddings with a specific provider example](/learn/by-example/rag-embedding-provider/)
- [The Ingest with OpenRouter embeddings example](/learn/by-example/rag-openrouter-ingestion/)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
