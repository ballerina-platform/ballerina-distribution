import ballerina/ai;
import ballerina/io;
import ballerina/mcp;

// A custom MCP toolkit for the ticket server. Each MCP tool is dispatched through a method of
// this class, so the method can read values from the `ai:Context` of the agent run and forward
// them to the server.
isolated class TicketToolKit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl,
            mcp:Implementation info = {name: "Support Assistant", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        // Map each MCP tool that the agent can use to the method that dispatches it.
        final map<ai:FunctionTool> permittedTools = {
            "getOpenTickets": self.getOpenTickets
        };
        do {
            self.mcpClient = check new (serverUrl, config);
            // Initialize the MCP session, list the tools of the server, and create the tool
            // configurations of the permitted tools with the schemas from the server.
            self.tools = check ai:getPermittedMcpToolConfigs(self.mcpClient, info, permittedTools)
                .cloneReadOnly();
        } on fail error e {
            return error("Failed to initialize the MCP toolkit", e);
        }
    }

    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    // The `ai:Context` parameter is supplied by the agent and is not part of the tool schema.
    // The `params` parameter carries the tool name and the arguments chosen by the LLM.
    @ai:AgentTool
    public isolated function getOpenTickets(ai:Context context, mcp:CallToolParams params)
            returns mcp:CallToolResult|error {
        string tenantId = check context.getWithType("tenantId");
        // The tenant is sent as request metadata rather than as a tool argument, so it stays
        // out of the tool schema and the LLM can neither see it nor choose a different value.
        return self.mcpClient->callTool({
            name: params.name,
            arguments: params.arguments,
            _meta: {"tenantId": tenantId}
        });
    }
}

// Connect to the MCP server from the MCP service with request metadata example.
final TicketToolKit ticketToolKit = check new ("http://localhost:9090/mcp");

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Support Assistant",
        instructions: "You answer questions about the support tickets of the signed-in user. Keep answers brief."
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    tools: [ticketToolKit]
});

public function main() returns error? {
    // The tenant of the signed-in user comes from the application, so it is passed to the
    // tool through the context instead of the query.
    ai:Context context = new;
    context.set("tenantId", "acme");
    string response = check supportAgent.run("What tickets are still open?", "user-1", context);
    io:println(response);
}
