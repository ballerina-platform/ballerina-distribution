import ballerina/ai;
import ballerina/io;
import ballerina/mcp;

// A custom MCP toolkit for the weather MCP server. Unlike `ai:McpToolKit`, which forwards every
// call as it is, each permitted MCP tool is dispatched through a method of this class, so the
// class decides how each call is made.
isolated class WeatherToolKit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;
    private final int maxForecastDays;

    public isolated function init(string serverUrl, int maxForecastDays = 3,
            mcp:Implementation info = {name: "Weather Assistant", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        self.maxForecastDays = maxForecastDays;
        // Map each MCP tool that the agent can use to the method that dispatches it.
        // Tools of the server that are not in this map are not given to the agent.
        final map<ai:FunctionTool> permittedTools = {
            "getCurrentWeather": self.getCurrentWeather,
            "getWeatherForecast": self.getWeatherForecast
        };
        do {
            // The client configuration, such as authentication, timeouts, and retries,
            // is passed on to the MCP client.
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

    // The `params` parameter carries the tool name and the arguments chosen by the LLM.
    @ai:AgentTool
    public isolated function getCurrentWeather(mcp:CallToolParams params)
            returns mcp:CallToolResult|error {
        return self.mcpClient->callTool(params);
    }

    @ai:AgentTool
    public isolated function getWeatherForecast(mcp:CallToolParams params)
            returns mcp:CallToolResult|error {
        // Adjust the arguments chosen by the LLM before the call is forwarded to the server.
        record {} arguments = {...params.arguments ?: {}};
        anydata days = arguments["days"];
        if days is int && days > self.maxForecastDays {
            io:println(string `[WeatherToolKit] Limiting the forecast from ${days} to ${
                self.maxForecastDays} days`);
            arguments["days"] = self.maxForecastDays;
        }
        return self.mcpClient->callTool({name: params.name, arguments});
    }
}

// Connect to the MCP server from the MCP service example.
final WeatherToolKit weatherToolKit = check new ("http://localhost:9090/mcp", maxForecastDays = 3);

final ai:Agent weatherAgent = check new (
    systemPrompt = {
        role: "Weather-aware AI Assistant",
        instructions: string `You are a smart AI assistant that can assist
            a user based on accurate and timely weather information.
            If a tool returns less data than the user asked for, say so.`
    },
    tools = [weatherToolKit],
    // Use the default model provider (with configuration added
    // via a Ballerina VS Code command).
    model = check ai:getDefaultModelProvider()
);

public function main() returns error? {
    string response = check weatherAgent.run(
        "What is the weather in Colombo now, and what is the forecast for the next 5 days?");
    io:println("Agent: ", response);
}
