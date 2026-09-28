import ballerina/io;
import ballerina/mcp;

public function main() returns error? {
    // Connect to the MCP server from the MCP service with request metadata example.
    mcp:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");
    check mcpClient->initialize({name: "Support MCP Client", version: "1.0.0"});

    // The `mcp:Meta?` parameters of the tools are not part of their input schemas, so only the
    // tool arguments are listed.
    mcp:ListToolsResult toolsResult = check mcpClient->listTools();
    foreach mcp:ToolDefinition tool in toolsResult.tools {
        string[] arguments = (tool.inputSchema.properties ?: {}).keys();
        io:println(string `Tool: ${tool.name}, arguments: ${arguments.toString()}`);
    }

    // The tenant is sent in the `_meta` field of the request instead of as a tool argument.
    // `mcp:Meta` is an open record, so the client can attach its own fields to it.
    mcp:CallToolResult result = check mcpClient->callTool({
        name: "getOpenTickets",
        _meta: {"tenantId": "acme"}
    });
    printResult("Open tickets of tenant 'acme'", result);

    // A call can carry both the tool arguments and the request metadata.
    result = check mcpClient->callTool({
        name: "createTicket",
        arguments: {"subject": "Invoices are not emailed", "priority": "high"},
        _meta: {"tenantId": "acme"}
    });
    printResult("Created ticket", result);

    // A tool that does not read the request metadata is called with the arguments only.
    result = check mcpClient->callTool({
        name: "getSupportHours",
        arguments: {"region": "EU"}
    });
    printResult("Support hours", result);

    // Without the metadata, the tool returns an error. An error returned by a tool is reported
    // as a result with the `isError` field set to `true`, rather than as a client error.
    result = check mcpClient->callTool({name: "getOpenTickets"});
    printResult("Call without metadata", result);

    check mcpClient->close();
}

function printResult(string label, mcp:CallToolResult result) {
    string status = result.isError == true ? "failed" : "succeeded";
    foreach mcp:ContentBlock content in result.content {
        if content is mcp:TextContent {
            io:println(string `${label} (${status}): ${content.text}`);
        }
    }
}
