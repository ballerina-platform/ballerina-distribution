import ballerina/io;
import ballerina/mcp;

public function main() returns error? {
    // Connect to the MCP server from the MCP advanced service with request metadata example.
    mcp:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");
    check mcpClient->initialize({name: "Support MCP Client", version: "1.0.0"});

    // The `getOpenTickets` tool takes no arguments. The tenant is not part of the tool's input
    // schema; it is sent in the `_meta` field of the request instead. `mcp:Meta` is an open
    // record, so the client can attach its own fields to it.
    mcp:CallToolResult result = check mcpClient->callTool({
        name: "getOpenTickets",
        _meta: {"tenantId": "acme"}
    });
    foreach mcp:ContentBlock content in result.content {
        if content is mcp:TextContent {
            io:println("Open tickets of tenant 'acme': ", content.text);
        }
    }

    // A call without the metadata is rejected by the service.
    mcp:CallToolResult|mcp:ClientError missingMetadata = mcpClient->callTool({name: "getOpenTickets"});
    if missingMetadata is mcp:ClientError {
        io:println("Call without metadata failed: ", missingMetadata.message());
    }

    check mcpClient->close();
}
