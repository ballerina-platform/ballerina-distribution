# Model Context Protocol (MCP) client with request metadata

An MCP request can carry a `_meta` field alongside the tool arguments. Metadata describes the call rather than forming part of the input of the tool, so it is the place for values that the caller determines and that must not be chosen by an LLM, such as the tenant or the correlation ID of the request.

The `mcp:StreamableHttpClient` client sends request metadata via the `_meta` field of `mcp:CallToolParams`. The `mcp:Meta` type is an open record, so the client can attach its own fields in addition to the standard `progressToken` field. On the server side, a service declared with the `mcp:StreamableHttpAdvancedService` type reads the metadata from the `mcp:CallToolParams` it receives in the `onCallTool` method.

This example demonstrates how to call a tool with request metadata that identifies the calling tenant, and shows that the same call is rejected when the metadata is missing.

> Note: Start the MCP server from the [MCP advanced service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example before running this example.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client_with_request_metadata.bal :::

::: out mcp_client_with_request_metadata.out :::

## Related links

- [The MCP advanced service with request metadata example](/learn/by-example/mcp-service-with-request-metadata/)
- [The MCP client example](/learn/by-example/mcp-client/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
