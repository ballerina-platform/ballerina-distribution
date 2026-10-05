# Retrieve and generate with Google Vertex AI

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and returns the most similar chunks from the vector store. You then add the chunks to the prompt, for example with `ai:augmentUserQuery`, and generate the answer with a model provider.

This example uses a [Google Vertex AI](https://cloud.google.com/vertex-ai) embedding model and the Gemini model (`google/gemini-2.5-flash`) through the [ballerinax/ai.googleapis.vertex](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest) module. It ingests documents into the in-memory vector store first, and then retrieves the relevant chunks and generates the answer.

For the ingestion part, see the [Ingest with Google Vertex AI embeddings](/learn/by-example/rag-vertex-ai-ingestion/) example.

> Note: Create a Google Cloud service account with access to Vertex AI, download its JSON key file, and add the path, the project ID, and the location to the `Config.toml` file (e.g., `serviceAccountKeyPath = "/path/to/key.json"`, `projectId = "<gcp-project-id>"`, `location = "us-central1"`). Never commit credentials to source control.

For more information on the underlying module, see the [`ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest).

::: code rag_vertex_ai_retrieval.bal :::

::: out rag_vertex_ai_retrieval.out :::

## Related links

- [The Ingest with Google Vertex AI embeddings example](/learn/by-example/rag-vertex-ai-ingestion/)
- [The Retrieve and generate with OpenRouter example](/learn/by-example/rag-openrouter-retrieval/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
