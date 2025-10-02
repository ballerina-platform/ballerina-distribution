import ballerina/ai;
import ballerina/io;

// Define an MCP toolkit to connect to the MCP service.
// This allows using all the tools registered with the MCP service.
// Alternatively, specific tools can be used by specifying them as the second 
// argument (e.g., `check new ("http://localhost:9090/mcp", ["getCurrentWeather"])`).
ai:McpToolKit weatherMcpConn = check new ("http://localhost:9090/mcp");

ai:Agent weatherAgent = check new (
    systemPrompt = {
        role: "Weather-aware AI Assistant",
        instructions: string `You are a smart AI assistant that can assist 
            a user based on accurate and timely weather information.`
    }, 
    tools = [weatherMcpConn],
    // Use the default model provider (with configuration added
    // via a Ballerina VS Code command).
    model = check ai:getDefaultModelProvider()
);

public function main() returns error? {
    while true {
        string userInput = io:readln("User (or 'exit' to quit): ");
        if userInput == "exit" {
            break;
        }
        // Pass the user input to the agent and get a response.
        string response = check weatherAgent.run(userInput);
        io:println("Agent: ", response);
    }
}
