# Passing context to MCP tools

Some values, such as the tenant of the user, must come from your application rather than from the LLM. To send such a value to an MCP server, pass it to the agent in an `ai:Context` and forward it in the `_meta` field of the request. In a custom MCP toolkit that includes the `ai:McpBaseToolKit` type, the tool method declares an `ai:Context` as its first parameter, followed by `mcp:CallToolParams`. The server reads the value through an `mcp:Meta?` parameter, as shown in the [MCP service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example.

This example reads the tenant from the context and sends it as request metadata.

> Note:<br />• Start the MCP server from the [MCP service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example before running this example.<br />• This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_mcp_context.bal :::

::: out ai_agent_mcp_context.out :::

## Related links
- [The MCP service with request metadata example](/learn/by-example/mcp-service-with-request-metadata/)
- [The MCP client with request metadata example](/learn/by-example/mcp-client-with-request-metadata/)
- [The Agent with advanced MCP integration example](/learn/by-example/ai-agent-mcp-integration-advanced/)
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
