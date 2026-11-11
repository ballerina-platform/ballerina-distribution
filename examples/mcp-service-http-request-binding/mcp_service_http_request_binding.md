# Model Context Protocol (MCP) tools with HTTP request binding

MCP tools defined as remote methods of an `mcp:StreamableHttpService` receive the arguments provided by the AI client. Tools often need information from the underlying HTTP request too, such as tenant identifiers, correlation IDs, or authorization headers set by a gateway.

Tool remote methods can additionally bind HTTP request information: an `http:Headers` parameter, an `http:Request` parameter, or `@http:Header` annotated parameters. These parameters are excluded from the tool's input schema, so they are never provided by the AI client and are instead populated from the incoming request.

This example demonstrates an MCP server whose tools use the `x-tenant-id` HTTP header to scope the data returned to the tenant making the request.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service_http_request_binding.bal :::

Run the service by executing the command below.

::: out mcp_service_http_request_binding.server.out :::

Invoke the service using the cURL commands below. The tenant is identified by the `x-tenant-id` header, which is not part of the tool arguments.

::: out mcp_service_http_request_binding.client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP service security example](/learn/by-example/mcp-service-security/)
- [The MCP client example](/learn/by-example/mcp-client/)
