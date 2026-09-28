# Agent definitions

An agent definition is a reusable template for an agent. It captures the role, the instructions, the tools, and the response type once, so that the same agent can be created in more than one place, used as a tool of another agent, or shared with other projects by publishing it in a library package.

A definition is a class that includes the `ai:FixedTypedAgent` type. The class composes an `ai:Agent` in its `init` method and implements the `run` method, which returns the fixed response type of the definition, and the `trace` method, which returns the execution trace. The parameters of the `init` method are the parts that vary between the agents created from the definition, such as the model provider, the memory, and values such as an endpoint or a tenant. Everything else stays in the definition. A structured response type is easier for the callers to use than a `string`, since the result needs no further interpretation.

This example demonstrates an agent definition that triages support requests, and creates two agents from it for two products with different categories.

> Note: The response type and the `init` parameters of a published definition are its public API. Changing the response type, adding a required `init` parameter, or renaming or removing any `init` parameter breaks its consumers.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_definitions.bal :::

::: out ai_agent_definitions.out :::

## Related links
- [The Agent as a tool example](/learn/by-example/ai-agent-as-tool/)
- [The Agent with typed input and output example](/learn/by-example/ai-agent-typed-input-output/)
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
