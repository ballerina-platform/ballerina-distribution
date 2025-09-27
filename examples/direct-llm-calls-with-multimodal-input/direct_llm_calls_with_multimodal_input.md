# Direct large language model (LLM) calls with multimodal input

The `ai:ModelProvider` type is a unified abstraction to integrate with large language models (LLMs) through provider-specific modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest), etc.

If multimodal input is supported by an LLM, the model provider implementation for the LLM handles insertions of the `ai:Document` types (`ai:ImageDocument`, `ai:AudioDocument`, and `ai:FileDocument`) as multimodal input, and creates the request as expected by the LLM API.

This example demonstrates how to make direct calls to LLMs using the model provider, with multimodal input. 

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code direct_llm_calls_with_multimodal_input.bal :::

::: out direct_llm_calls_with_multimodal_input.out :::

## Related links
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
