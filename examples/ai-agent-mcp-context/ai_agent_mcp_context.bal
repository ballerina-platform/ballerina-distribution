import ballerina/ai;
import ballerina/io;
import ballerina/mcp;

// Connects to the MCP server from the MCP advanced service with request metadata example.
final mcp:StreamableHttpClient ticketServer = check new ("http://localhost:9090/mcp");

# Gets the open support tickets of the signed-in user.
# + context - The context carrying the tenant of the signed-in user
# + return - The open tickets of the tenant, or an error if the call fails
@ai:AgentTool
isolated function getOpenTickets(ai:Context context) returns string|error {
    string tenantId = check context.getWithType("tenantId");
    // The tenant is sent as request metadata rather than as a tool argument, so it stays out
    // of the tool schema and the LLM can neither see it nor choose a different value.
    mcp:CallToolResult result = check ticketServer->callTool({
        name: "getOpenTickets",
        _meta: {"tenantId": tenantId}
    });
    return result.content.toJsonString();
}

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Support Assistant",
        instructions: "You answer questions about the support tickets of the signed-in user. Keep answers brief."
    },
    model: check ai:getDefaultModelProvider(),
    tools: [getOpenTickets]
});

public function main() returns error? {
    check ticketServer->initialize({name: "Support Assistant", version: "1.0.0"});

    // The tenant of the signed-in user comes from the application, so it is passed to the
    // tool through the context instead of the query.
    ai:Context context = new;
    context.set("tenantId", "acme");
    string response = check supportAgent.run("What tickets are still open?", "user-1", context);
    io:println(response);

    check ticketServer->close();
}
