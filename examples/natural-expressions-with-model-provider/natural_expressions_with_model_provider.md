# Natural expressions with a specific model provider

Natural expressions provide a language-level abstraction for integrating with large language models (LLMs). A natural expression can optionally specify the `ai:ModelProvider` to use as an argument, so you can use a specific provider with your own keys rather than the default model provider.

This example demonstrates how to use a natural expression with a specific model provider, initialized with your own API key. The example uses Anthropic via the [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest) module, but any `ai:ModelProvider` implementation (e.g., [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest)) can be used.

> Note: Add the API key to the `Config.toml` file (e.g., `anthropicApiKey = "<your-api-key>"`). Never commit API keys to source control.

> Note: This feature is supported on Swan Lake Update 13 or newer versions. This is currently an experimental feature and requires the `--experimental` flag to be used with `bal` commands.

For more information on the underlying module, see the [`ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest).

::: code natural_expressions_with_model_provider.bal :::

::: out natural_expressions_with_model_provider.out :::

## Related links

- [The Natural expressions example](/learn/by-example/natural-expressions/)
- [Natural Language is Code: A hybrid approach with Natural Programming](https://blog.ballerina.io/posts/2025-04-26-introducing-natural-programming/)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
