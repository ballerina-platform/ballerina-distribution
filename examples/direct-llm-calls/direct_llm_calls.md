# Direct large language model (LLM) calls

The `ai:ModelProvider` type is a unified abstraction to integrate with large language models (LLMs) through provider-specific modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest), etc.

The `generate` method of the model provider accepts a prompt in natural language, generates a JSON schema corresponding to the type descriptor argument (generally, the expected type), makes the call to the LLM, and binds the relevant content from the response to the expected type, allowing seamless integration with LLMs.

This example demonstrates how to make direct calls to LLMs using the model provider, enabling type-safe AI integrations across different providers. 

> Note: This example uses the default model provider implementation. Log in to the Ballerina Copilot, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your keys to the `Config.toml` file. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code direct_llm_calls.bal :::

::: out direct_llm_calls.out :::

## Related links
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
