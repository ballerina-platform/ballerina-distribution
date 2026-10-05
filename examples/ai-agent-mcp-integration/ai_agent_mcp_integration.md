# AI agents with MCP tools

An AI agent can use the tools of a Model Context Protocol (MCP) server through the `ai:McpToolKit` toolkit, which forwards each call to the server as it is. For more control, such as changing the arguments of a call, define a custom MCP toolkit, as shown in the [Agent with advanced MCP integration](/learn/by-example/ai-agent-mcp-integration-advanced/) example.

This example creates an agent that answers questions with the tools of a weather MCP service.

> Note:<br />• You can use this agent with the [MCP service example](/learn/by-example/mcp-service/).<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_integration.bal :::

::: out ai_agent_mcp_integration.out :::

## Related links
- [The Agent with advanced MCP integration example](/learn/by-example/ai-agent-mcp-integration-advanced/)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration)
- [The Agent with tool kits example](/learn/by-example/ai-agent-tool-kit)
- [The `ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest)
- [The `ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest)
- [The `ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest)
