# Natural functions

A natural function has a signature declared in Ballerina and a body that is a natural expression written in English. At runtime, the parameters are interpolated into the prompt, the return type is sent to the LLM as a JSON schema, and the response is bound to the return type. Callers use it like any other function. It works with any `ai:ModelProvider` implementation, including the default model provider.

This example uses a natural function to analyze a customer review and return a typed result.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

> Note: This feature is supported on Swan Lake Update 13 or newer versions. This is currently an experimental feature and requires the `--experimental` flag to be used with `bal` commands.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code natural_functions.bal :::

::: out natural_functions.out :::

## Related links

- [The Natural expressions example](/learn/by-example/natural-expressions/)
- [The Natural expressions with a specific model provider example](/learn/by-example/natural-expressions-with-model-provider/)
- [Natural Language is Code: A hybrid approach with Natural Programming](https://blog.ballerina.io/posts/2025-04-26-introducing-natural-programming/)
- [The `ballerina/ai.np` module](https://central.ballerina.io/ballerina/ai.np/latest)
