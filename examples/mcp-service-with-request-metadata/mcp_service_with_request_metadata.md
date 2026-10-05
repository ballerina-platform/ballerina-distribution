# Model Context Protocol (MCP) service with request metadata

An MCP request can carry a `_meta` field for values that the caller sets and the LLM must not choose, such as the tenant. A tool of an `mcp:StreamableHttpService` reads it through an `mcp:Meta?` parameter, which is not part of the tool input schema.

This example exposes three support tools: two read the tenant from the metadata, and one does not.

> Note: The `onCallTool` method of an `mcp:StreamableHttpAdvancedService` does not accept an `mcp:Meta?` parameter. It reads the metadata from the `_meta` field of the `mcp:CallToolParams` value that it receives instead.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service_with_request_metadata.bal :::

Run the service as follows.

::: out mcp_service_with_request_metadata.out :::

>**Tip:** You can invoke the above service via the [MCP client with request metadata](/learn/by-example/mcp-client-with-request-metadata/) example.

## Related links
- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP client with request metadata example](/learn/by-example/mcp-client-with-request-metadata/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
