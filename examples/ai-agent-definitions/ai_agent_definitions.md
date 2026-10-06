# Agent definitions

An agent definition is a reusable agent. Define the role, instructions, tools, and response type once in a class that includes `ai:FixedTypedAgent`, and create as many agents from it as you need. The `init` parameters hold what changes between agents, such as the model provider or the product.

Since a definition is a class, you can share it by publishing it in a library package, so other projects can import it and create their own agents. An agent created from a definition can also be used as a tool of another agent, as shown in the [Agent as a tool](/learn/by-example/ai-agent-as-tool/) example.

This example defines a support triage agent and creates two agents from it, one for each product.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_definitions.bal :::

::: out ai_agent_definitions.out :::

## Related links
- [The Agent as a tool example](/learn/by-example/ai-agent-as-tool/)
- [The Agent with typed input and output example](/learn/by-example/ai-agent-typed-input-output/)
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
