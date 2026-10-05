# Model Context Protocol (MCP) client with request metadata

An MCP request can carry a `_meta` field for values that the caller sets and the LLM must not choose, such as the tenant. The `mcp:StreamableHttpClient` client sends it through the `_meta` field of `mcp:CallToolParams`. `mcp:Meta` is an open record, so you can add your own fields. An error returned by a tool comes back as an `mcp:CallToolResult` with `isError` set to `true`, not as an `mcp:ClientError`.

This example calls tools with metadata, arguments, or both, and shows a call that fails without the required metadata.

> Note: Start the MCP server from the [MCP service with request metadata](/learn/by-example/mcp-service-with-request-metadata/) example before running this example.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client_with_request_metadata.bal :::

::: out mcp_client_with_request_metadata.out :::

## Related links

- [The MCP service with request metadata example](/learn/by-example/mcp-service-with-request-metadata/)
- [The MCP client example](/learn/by-example/mcp-client/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
