# Natural expressions

Natural expressions provide a language-level abstraction for integrating with large language models (LLMs), enabling developers to seamlessly combine natural language instructions with Ballerina code while maintaining programming language principles and leveraging the strengths of the type system. Unlike simple method calls, natural expressions clearly distinguish between traditional logic and LLM-driven logic.

Natural expressions use the `ai:ModelProvider` type as a unified interface for working with different LLM providers such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest), [ballerinax/ai.anthropic](https://central.ballerina.io/ballerinax/ai.anthropic/latest), and others. The expression automatically generates a JSON schema from the expected return type, sends the prompt to the LLM, and binds the response to the specified type.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

> Note: This feature is supported on Swan Lake Update 13 - Milestone 3 (2201.13.0-m3) or newer versions. This is currently an experimental feature and requires the `--experimental` flag to be used with `bal` commands.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code natural_expressions.bal :::

::: out natural_expressions.out :::

## Related links

- [Natural Language is Code: A hybrid approach with Natural Programming](https://blog.ballerina.io/posts/2025-04-26-introducing-natural-programming/)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
