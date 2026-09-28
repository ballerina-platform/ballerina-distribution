# AI agents with advanced MCP integration

The `ai:McpToolKit` toolkit gives an agent the tools of an MCP server, or a subset of them, and forwards each call to the server as it is. For more control over how each call is made, such as changing its arguments or adding request metadata, define a custom MCP toolkit instead.

A custom MCP toolkit is a class that includes the `ai:McpBaseToolKit` type and holds an `mcp:StreamableHttpClient` client. In its `init` method, the `ai:getPermittedMcpToolConfigs` function initializes the MCP session, lists the tools of the server, and creates the tool configurations with the schemas from the server. The tools are mapped to methods of the class, each annotated with `@ai:AgentTool`, that dispatch the calls. Only the mapped tools are given to the agent, and each dispatch method receives the tool name and the arguments chosen by the LLM as an `mcp:CallToolParams` value, so it can inspect or change the call before forwarding it to the server. The class also defines its own `init` parameters, such as the limits it enforces, and passes the client configuration, such as authentication, on to the MCP client.

This example demonstrates a custom MCP toolkit for a weather MCP server that limits the number of forecast days that the agent can request.

> Note: Start the MCP server from the [MCP service](/learn/by-example/mcp-service/) example before running this example.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_integration_advanced.bal :::

::: out ai_agent_mcp_integration_advanced.out :::

## Related links
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP client example](/learn/by-example/mcp-client/)
