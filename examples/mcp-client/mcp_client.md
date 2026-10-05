# Model Context Protocol (MCP) client

The `mcp:StreamableHttpClient` client connects to an MCP server over the Streamable HTTP transport. It performs the protocol handshake, discovers the tools of the server, and calls them. Use it to call MCP tools without an AI agent. To use MCP tools from an agent, use `ai:McpToolKit`, as shown in the [Agent with MCP integration](/learn/by-example/ai-agent-mcp-integration/) example.

This example connects to an MCP server, lists its tools, calls a tool, and closes the connection.

> Note: Start the MCP server from the [MCP service](/learn/by-example/mcp-service/) example before running this example.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client.bal :::

::: out mcp_client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP advanced service example](/learn/by-example/mcp-service-advanced/)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
