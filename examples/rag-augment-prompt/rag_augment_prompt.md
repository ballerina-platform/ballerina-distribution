# Augment the prompt with retrieved context

In a retrieval-augmented generation (RAG) application, the documents are first loaded, split into chunks, embedded, and stored in a vector store. When a user asks a question, the question is embedded too, and the most relevant chunks are retrieved from the vector store. The last step is to add these chunks to the user's query as context, so that the large language model (LLM) answers from your data.

The `ai:augmentUserQuery` function adds the chunks to the query with a generic prompt template. For full control, insert the chunks into your own prompt and pass it to the `generate` method.

This example shows both approaches with the default model provider, using retrieved chunks defined inline.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_augment_prompt.bal :::

::: out rag_augment_prompt.out :::

## Related links

- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
