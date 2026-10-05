# Direct LLM calls with a specific model provider

The `ai:ModelProvider` type is a unified abstraction to integrate with large language models (LLMs). Provider-specific modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest), [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest), and others implement this type, so the same code works across providers.

This example demonstrates how to initialize an OpenAI model provider with your own keys and use it to make direct LLM calls to the `gpt-5-mini` model through the Responses API.

> Note: Add the API key to the `Config.toml` file (e.g., `openAiApiKey = "<your-api-key>"`). Never commit API keys to source control. Alternatively, to avoid managing keys yourself, use the default model provider via `ai:getDefaultModelProvider()`, as demonstrated in the [Direct LLM calls](/learn/by-example/direct-llm-calls/) example.

For more information on the underlying module, see the [`ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest).

::: code direct_llm_calls_with_model_provider.bal :::

::: out direct_llm_calls_with_model_provider.out :::

## Related links
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
