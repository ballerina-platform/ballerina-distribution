# AI agents with advanced MCP integration

The `ai:McpToolKit` toolkit forwards each tool call to the MCP server unchanged. When you need more control over these calls, define a custom MCP toolkit: a class that includes the `ai:McpBaseToolKit` type and uses an `mcp:StreamableHttpClient` client. The `ai:getPermittedMcpToolConfigs` function maps each MCP tool to a method of the class annotated with `@ai:AgentTool`. Each method receives the call as an `mcp:CallToolParams` value, so it can change the call before forwarding it to the server.

This example limits the number of forecast days that the agent can request from a weather MCP server.

> Note:<br />• Start the MCP server from the [MCP service](/learn/by-example/mcp-service/) example before running this example.<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_integration_advanced.bal :::

::: out ai_agent_mcp_integration_advanced.out :::

## Related links
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP client example](/learn/by-example/mcp-client/)
