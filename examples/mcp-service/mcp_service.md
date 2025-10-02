# Model Context Protocol (MCP) service

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts). 

Ballerina's MCP library allows you to create MCP servers that expose tools. Remote methods of a `mcp:Service` service declaration automatically become MCP tools that AI assistants can discover and call.

This example demonstrates how to create an MCP server that exposes weather-related tools, allowing AI assistants to discover and use tools to retrieve current weather data and forecasts for different locations.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service.bal :::

::: out mcp_service.out :::

## Related links

- [AI agents integrated with MCP servers example](/learn/by-example/ai-agent-mcp-integration/)
