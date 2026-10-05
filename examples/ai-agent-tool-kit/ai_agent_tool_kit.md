# AI agents with tool kits

A toolkit groups related tools into one reusable class. It includes the `ai:BaseToolKit` type and returns its tools from the `getTools` method. Its own `init` method controls how the tools are created. Here, the toolkit keeps the HTTP client and the API credentials to itself, so they never reach the LLM. The `permittedTools` parameter selects the tools the agent gets.

This example gives a to-do list agent a task management toolkit that can list and add tasks, but not complete them.

> Note:<br />• The example starts a mock task management API on port 9095, so that it is self-contained.<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_kit.bal :::

::: out ai_agent_tool_kit.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration)
- [The Agent with advanced MCP integration example](/learn/by-example/ai-agent-mcp-integration-advanced)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
