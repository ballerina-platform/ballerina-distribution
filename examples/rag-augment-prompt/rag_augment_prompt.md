# Augment the prompt with retrieved context

The final step of a retrieval-augmented generation (RAG) workflow is generation: the chunks retrieved for the user's question are added to the prompt, so that the large language model (LLM) answers from your data instead of from its training data alone. Ballerina offers two ways to do this.

The `ai:augmentUserQuery` function takes the retrieved chunks (`ai:QueryMatch[]` or `ai:Document[]`) and the query, and returns an `ai:ChatUserMessage` that combines them using a generic prompt template. The content of the message is an `ai:Prompt`, so it can be passed to the `generate` method of a model provider (or the message itself can be sent with the `chat` method). For full control over the prompt, insert the chunks into your own prompt template and pass it to the `generate` method. The `generate` method binds the answer to the expected type, so you can ask the model for structured output such as an answer together with a grounding flag.

This example demonstrates both approaches with the default model provider. The retrieved chunks are defined inline to focus on the augmentation step; see the retrieval examples for how they are retrieved from a knowledge base.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_augment_prompt.bal :::

::: out rag_augment_prompt.out :::

## Related links

- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
