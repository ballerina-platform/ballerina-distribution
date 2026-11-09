# Model Context Protocol (MCP) service with elicitation

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts).

With the current MCP protocol, a tool can ask the user for input while it runs. The tool returns an `mcpv2:InputRequiredResult` instead of its result, with the input requests built using `mcpv2:elicitForm`. The client collects the answers from the user and calls the tool again, and the tool reads them through its `mcpv2:Context` parameter. The form schema is generated from a record type at compile time, and `acceptedContent` reads the answer back as the same type.

Since the tool runs again from the top on every round, keep the work done before it asks for input safe to repeat.

This example demonstrates how to create an MCP server with a tool that asks the user for the details of a table booking.

For more information on the underlying module, see the [`ballerina/mcp.v2` module](https://lib.ballerina.io/ballerina/mcp.v2/latest/).

::: code mcp_v2_service_elicitation.bal :::

::: out mcp_v2_service_elicitation.out :::

> **Tip:** A `mcpv2:StreamableHttpClient` answers elicitations through the function given as its `elicitationHandler`.

## Related links

- [The MCP service with the v2 module example](/learn/by-example/mcp-v2-service/)
- [The MCP client with the v2 module example](/learn/by-example/mcp-v2-client/)
