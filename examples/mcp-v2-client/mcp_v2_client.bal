import ballerina/io;
import ballerina/mcp.v2 as mcpv2;

public function main() returns error? {
    // Create a client for the MCP server running at the given URL.
    mcpv2:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");

    // Connect to the server. The client uses the current MCP protocol and
    // falls back to the initialize handshake for older servers.
    mcpv2:ConnectionInfo connection = check mcpClient->connect({
        name: "weather-client",
        version: "1.0.0"
    });
    io:println("Connected using MCP ", connection.protocolVersion);

    // Discover the tools the server exposes.
    mcpv2:ListToolsResult tools = check mcpClient->listTools();
    foreach mcpv2:ToolDefinition tool in tools.tools {
        io:println("Tool: ", tool.name);
    }

    // Call a tool with its arguments.
    mcpv2:CallToolResult result = check mcpClient->callTool({
        name: "getCurrentWeather",
        arguments: {"city": "London"}
    });
    // Print the text content blocks of the result.
    foreach mcpv2:ContentBlock block in result.content {
        if block is mcpv2:TextContent {
            io:println("Weather: ", block.text);
        }
    }

    check mcpClient->close();
}
