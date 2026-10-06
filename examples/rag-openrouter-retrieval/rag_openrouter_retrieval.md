# Retrieve and generate with OpenRouter

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `retrieve` method embeds the question with the same embedding provider that was used for ingestion, and returns the most similar chunks from the vector store. You then add the chunks to the prompt, for example with `ai:augmentUserQuery`, and generate the answer with a model provider.

This example uses an embedding model and an LLM (`openai/gpt-4o-mini`) on [OpenRouter](https://openrouter.ai/) through the [ballerinax/ai.openrouter](https://central.ballerina.io/ballerinax/ai.openrouter/latest) module. It ingests documents into the in-memory vector store first, and then retrieves the relevant chunks and generates the answer.

For the ingestion part, see the [Ingest with OpenRouter embeddings](/learn/by-example/rag-openrouter-ingestion/) example.

> Note: Add the OpenRouter API key to the `Config.toml` file (e.g., `openRouterApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest).

::: code rag_openrouter_retrieval.bal :::

::: out rag_openrouter_retrieval.out :::

## Related links

- [The Ingest with OpenRouter embeddings example](/learn/by-example/rag-openrouter-ingestion/)
- [The Retrieve and generate with Google Vertex AI example](/learn/by-example/rag-vertex-ai-retrieval/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
