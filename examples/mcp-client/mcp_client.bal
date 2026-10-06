import ballerina/io;
import ballerina/mcp;

public function main() returns error? {
    // Create an MCP client for an MCP server that uses the Streamable HTTP transport.
    // This example connects to the MCP server from the MCP service example.
    mcp:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");

    // Initialize the connection. This performs the protocol handshake and
    // capability exchange with the server.
    check mcpClient->initialize({name: "Weather MCP Client", version: "1.0.0"});

    // Discover the tools exposed by the server.
    mcp:ListToolsResult toolsResult = check mcpClient->listTools();
    io:println("Available tools:");
    foreach mcp:ToolDefinition tool in toolsResult.tools {
        io:println("- ", tool.name, ": ", tool.description);
    }

    // Call a tool by name with the arguments expected by its input schema.
    mcp:CallToolResult result = check mcpClient->callTool({
        name: "getCurrentWeather",
        arguments: {"city": "Colombo"}
    });

    // The result contains one or more content blocks. Tools implemented in
    // Ballerina return their result as text content.
    foreach mcp:ContentBlock content in result.content {
        if content is mcp:TextContent {
            io:println("\nCurrent weather in Colombo: ", content.text);
        }
    }

    // Close the session and disconnect from the server.
    check mcpClient->close();
}
