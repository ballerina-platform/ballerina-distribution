# Model Context Protocol (MCP) advanced service

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts). 

Ballerina's MCP library allows you to create MCP servers that expose tools. A `mcp:AdvancedService` service expects two remote methods, namely `onListTools` and `onCallTool`, to allow AI assistants to discover and call tools respectively.

This example demonstrates how to create an MCP server that exposes weather-related tools via explicit MCP methods, allowing AI assistants to discover and use tools to retrieve current weather data and forecasts for different locations.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service_advanced.bal :::

::: out mcp_service_advanced.out :::

## Related links

- [The AI agents integrated with MCP servers example](/learn/by-example/ai-agent-mcp-integration/)
