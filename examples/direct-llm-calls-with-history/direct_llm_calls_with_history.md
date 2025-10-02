# Direct large language model (LLM) calls with history

The `ai:ModelProvider` type is a unified abstraction to integrate with large language models (LLMs) through provider-specific modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest), etc.

The `chat` method of the model provider accepts a user message or an array of chat messages, makes the call to the LLM with the message(s), and returns the relevant content of the response from the LLM.

This example demonstrates how to make direct calls to LLMs using the model provider, maintaining the chat history. 

> Note: This example uses the default model provider implementation. Log in to the Ballerina Copilot, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your keys to the `Config.toml` file. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code direct_llm_calls_with_history.bal :::

::: out direct_llm_calls_with_history.out :::

## Related links
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
