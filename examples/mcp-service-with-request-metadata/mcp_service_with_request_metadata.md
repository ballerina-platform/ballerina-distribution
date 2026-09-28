# Model Context Protocol (MCP) service with request metadata

An MCP request can carry a `_meta` field alongside the tool arguments. Metadata describes the call rather than forming part of the input of the tool, which makes it the place for values that the caller determines and the LLM must not choose, such as the tenant or the correlation ID of the request.

A tool of an `mcp:StreamableHttpService` reads the metadata by declaring an `mcp:Meta?` parameter. The runtime injects the `_meta` field of the request into the parameter and excludes the parameter from the generated tool input schema, so the metadata is never a tool argument and the LLM never sees it. The parameter must be nilable, since it is nil when the request carries no metadata, and a tool can declare at most one such parameter, in any position, alongside its other parameters. The `mcp:Meta` type is an open record, so the fields the client sent are read through member access. A tool that does not need the metadata simply does not declare the parameter.

This example exposes three tools of a support service. The `getOpenTickets` tool takes no arguments and scopes the result to the tenant sent in the request metadata. The `createTicket` tool takes the `subject` and `priority` arguments and reads the tenant from the request metadata. The `getSupportHours` tool takes the `region` argument and does not read the request metadata.

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
