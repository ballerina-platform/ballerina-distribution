# Model Context Protocol (MCP) service with the v2 module

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts).

The `ballerina/mcp.v2` module builds MCP servers over the Streamable HTTP transport. Remote methods of a `mcpv2:StreamableHttpService` service declaration automatically become MCP tools that AI assistants can discover and call. The input and output schemas of each tool are generated from the method signature and its documentation, and the return value is also sent as structured content.

The service supports the current MCP protocol and still serves clients that use the older initialize-based protocol.

This example demonstrates how to create an MCP server that exposes weather-related tools, allowing AI assistants to discover and use tools to retrieve current weather data and forecasts for different locations.

For more information on the underlying module, see the [`ballerina/mcp.v2` module](https://lib.ballerina.io/ballerina/mcp.v2/latest/).

::: code mcp_v2_service.bal :::

::: out mcp_v2_service.out :::

## Related links

- [The MCP client with the v2 module example](/learn/by-example/mcp-v2-client/)
- [The MCP advanced service with the v2 module example](/learn/by-example/mcp-v2-service-advanced/)
- [The MCP service with elicitation example](/learn/by-example/mcp-v2-service-elicitation/)
- [The AI agents integrated with MCP servers example](/learn/by-example/ai-agent-mcp-integration/)
