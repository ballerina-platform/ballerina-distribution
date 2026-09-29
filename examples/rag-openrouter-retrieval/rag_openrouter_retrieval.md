# Retrieve and generate with OpenRouter

The retrieval side of a retrieval-augmented generation (RAG) workflow embeds the user's question with the same embedding model that was used for ingestion, retrieves the most similar chunks, and augments the prompt sent to the LLM with them. With [OpenRouter](https://openrouter.ai/), both the embedding model and the LLM can be selected from many providers through a single API key, via the [ballerinax/ai.openrouter](https://central.ballerina.io/ballerinax/ai.openrouter/latest) module.

This example demonstrates retrieving chunks embedded through OpenRouter and generating the answer with an OpenRouter-hosted model (e.g., `openai/gpt-4o-mini`, `anthropic/claude-3.5-sonnet`). Since it uses the in-memory vector store, the documents are ingested in the same program. The ingestion for this example is explained in the [Ingest with OpenRouter embeddings](/learn/by-example/rag-openrouter-ingestion/) example.

> Note: Add the OpenRouter API key to the `Config.toml` file (e.g., `openRouterApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest).

::: code rag_openrouter_retrieval.bal :::

::: out rag_openrouter_retrieval.out :::

## Related links

- [The Ingest with OpenRouter embeddings example](/learn/by-example/rag-openrouter-ingestion/)
- [The Retrieve and generate with Google Vertex AI example](/learn/by-example/rag-vertex-ai-retrieval/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
