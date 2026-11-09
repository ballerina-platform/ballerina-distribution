# Model Context Protocol (MCP) client with the v2 module

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts).

The `mcpv2:StreamableHttpClient` connects to an MCP server over the Streamable HTTP transport. Calling `connect` selects the protocol: the client uses the current MCP protocol and falls back to the initialize handshake when the server only supports older protocol versions. After connecting, the client can list the tools of the server and call them.

This example demonstrates how to connect to an MCP server, discover its tools, and call one of them.

For more information on the underlying module, see the [`ballerina/mcp.v2` module](https://lib.ballerina.io/ballerina/mcp.v2/latest/).

::: code mcp_v2_client.bal :::

## Prerequisites

- Run the MCP service given in the [MCP service with the v2 module](/learn/by-example/mcp-v2-service/) example.

Run the client program by executing the following command.

::: out mcp_v2_client.out :::

## Related links

- [The MCP service with the v2 module example](/learn/by-example/mcp-v2-service/)
- [The MCP service with elicitation example](/learn/by-example/mcp-v2-service-elicitation/)
