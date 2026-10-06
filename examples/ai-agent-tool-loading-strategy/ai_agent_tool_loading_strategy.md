# Agent tool loading strategy

By default (`ai:NO_FILTER`), an agent gives the LLM the details of all its tools in every request. When an agent has many tools, this uses more tokens and costs more. With the `ai:LLM_FILTER` strategy, the agent loads only the tools that are relevant to the request. Set the strategy in the `toolLoadingStrategy` field of the agent configuration.

This example uses `ai:LLM_FILTER` in an HR assistant agent with several tools.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_loading_strategy.bal :::

::: out ai_agent_tool_loading_strategy.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with tool kits example](/learn/by-example/ai-agent-tool-kit/)
