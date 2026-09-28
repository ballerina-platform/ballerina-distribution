# Passing context to MCP tools

An agent that uses the tools of an MCP server often needs to send the server a value that the application knows and the LLM must not choose, such as the tenant of the signed-in user. The `ai:Context` carries that value from the caller of the agent to the tool, and the `_meta` field of the MCP request carries it on to the server. Neither appears in the schema sent to the LLM.

To forward such a value, define a custom MCP toolkit. It is a class that includes the `ai:McpBaseToolKit` type and holds an `mcp:StreamableHttpClient` client. The `ai:getPermittedMcpToolConfigs` function initializes the MCP session, lists the tools of the server, and creates the tool configurations of the permitted tools, each mapped to a method of the class that dispatches the call. A dispatch method can declare an `ai:Context` parameter as its first parameter, which the agent supplies, followed by the `mcp:CallToolParams` parameter that carries the tool name and the arguments chosen by the LLM. This example reads the tenant from the context and sets it on the `_meta` field of the request. On the server side, the tool reads it through an `mcp:Meta?` parameter, as demonstrated in the [MCP service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example.

> Note: Start the MCP server from the [MCP service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example before running this example.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_context.bal :::

::: out ai_agent_mcp_context.out :::

## Related links
- [The MCP service with request metadata example](/learn/by-example/mcp-service-with-request-metadata/)
- [The MCP client with request metadata example](/learn/by-example/mcp-client-with-request-metadata/)
- [The Agent with advanced MCP integration example](/learn/by-example/ai-agent-mcp-integration-advanced/)
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
