# Model Context Protocol (MCP) advanced service with request metadata

An MCP request can carry a `_meta` field alongside the tool arguments. Metadata describes the call rather than forming part of the input of the tool, which makes it the place for values that the caller determines and the LLM must not choose, such as the tenant or the correlation ID of the request. Since the metadata is not part of the tool input schema, the LLM never sees it.

A service declared with the `mcp:StreamableHttpAdvancedService` type receives the whole `mcp:CallToolParams` in its `onCallTool` method, including the `_meta` field. The `mcp:Meta` type is an open record, so a client can attach its own fields to it.

This example exposes a tool that lists support tickets, and scopes the result to the tenant sent in the request metadata.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service_with_request_metadata.bal :::

::: out mcp_service_with_request_metadata.out :::

## Related links
- [The MCP advanced service example](/learn/by-example/mcp-service-advanced/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
- [The MCP client example](/learn/by-example/mcp-client/)
