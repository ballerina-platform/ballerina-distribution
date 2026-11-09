# Model Context Protocol (MCP) advanced service with the v2 module

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts).

A `mcpv2:StreamableHttpAdvancedService` service defines tool discovery and dispatch itself. It expects two remote methods, namely `onListTools` and `onCallTool`, to allow AI assistants to discover and call tools respectively. Returning an `mcpv2:InvalidParamsError` rejects the call with a JSON-RPC `INVALID_PARAMS` error.

This example demonstrates how to create an MCP server that exposes weather-related tools via explicit MCP methods, allowing AI assistants to discover and use tools to retrieve current weather data and forecasts for different locations.

For more information on the underlying module, see the [`ballerina/mcp.v2` module](https://lib.ballerina.io/ballerina/mcp.v2/latest/).

::: code mcp_v2_service_advanced.bal :::

::: out mcp_v2_service_advanced.out :::

## Related links

- [The MCP service with the v2 module example](/learn/by-example/mcp-v2-service/)
- [The MCP client with the v2 module example](/learn/by-example/mcp-v2-client/)
