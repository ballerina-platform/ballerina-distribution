# Direct LLM calls with a local model using Ollama

[Ollama](https://ollama.com/) allows you to run open-source large language models (LLMs) such as Llama, Mistral, and Gemma locally. The [ballerinax/ai.ollama](https://central.ballerina.io/ballerinax/ai.ollama/latest) module provides an `ai:ModelProvider` implementation for locally running Ollama models, so the same APIs used with cloud providers work with a local model.

This example demonstrates how to make direct LLM calls to a model served by a local Ollama server.

> Note: Install Ollama, start the Ollama server, and pull the model before running the example (e.g., `ollama pull llama3.2`). To use a different model or a server running on another host or port, set the `ollamaModel` and `ollamaServiceUrl` configurable variables in the `Config.toml` file.

For more information on the underlying module, see the [`ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest).

::: code direct_llm_calls_with_ollama.bal :::

::: out direct_llm_calls_with_ollama.out :::

## Related links
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The Direct LLM calls with a specific model provider example](/learn/by-example/direct-llm-calls-with-model-provider/)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [Ollama documentation](https://github.com/ollama/ollama/blob/main/README.md)
