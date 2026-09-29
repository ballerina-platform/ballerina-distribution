# Retrieve and generate with Google Vertex AI

The retrieval side of a retrieval-augmented generation (RAG) workflow embeds the user's question with the same embedding model that was used for ingestion, retrieves the most similar chunks, and augments the prompt sent to the LLM with them. With [Google Vertex AI](https://cloud.google.com/vertex-ai), both steps can use Google models: a Vertex AI embedding model for the retrieval and a Gemini model for the answer, via the [ballerinax/ai.googleapis.vertex](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest) module.

This example demonstrates retrieving chunks embedded with Vertex AI and generating the answer with Gemini. Since it uses the in-memory vector store, the documents are ingested in the same program. The ingestion for this example is explained in the [Ingest with Google Vertex AI embeddings](/learn/by-example/rag-vertex-ai-ingestion/) example.

> Note: Create a Google Cloud service account with access to Vertex AI, download its JSON key file, and add the path, the project ID, and the location to the `Config.toml` file (e.g., `serviceAccountKeyPath = "/path/to/key.json"`, `projectId = "<gcp-project-id>"`, `location = "us-central1"`). Never commit credentials to source control.

For more information on the underlying module, see the [`ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest).

::: code rag_vertex_ai_retrieval.bal :::

::: out rag_vertex_ai_retrieval.out :::

## Related links

- [The Ingest with Google Vertex AI embeddings example](/learn/by-example/rag-vertex-ai-ingestion/)
- [The Retrieve and generate with OpenRouter example](/learn/by-example/rag-openrouter-retrieval/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
