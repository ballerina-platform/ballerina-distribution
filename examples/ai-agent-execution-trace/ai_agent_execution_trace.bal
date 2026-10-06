import ballerina/ai;
import ballerina/io;
import ballerina/time;

# Gets the current stock level of a product.
# + productId - The product ID
# + return - The number of units in stock
@ai:AgentTool
isolated function getStockLevel(string productId) returns int => productId == "P-100" ? 3 : 25;

# Gets the number of units of a product on order from suppliers.
# + productId - The product ID
# + return - The number of units on order
@ai:AgentTool
isolated function getUnitsOnOrder(string productId) returns int => productId == "P-100" ? 50 : 0;

final ai:Agent inventoryAgent = check new ({
    systemPrompt: {
        role: "Inventory Assistant",
        instructions: "You answer questions about product inventory using the tools. Be concise."
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    tools: [getStockLevel, getUnitsOnOrder]
});

public function main() returns error? {
    // Request the full execution trace by using `ai:Trace` as the expected type.
    // The trace captures each reasoning-action cycle (iteration), the tool calls made by
    // the LLM, the tool results, the final output, and the timings.
    ai:Trace trace = check inventoryAgent.run("Is product P-100 running low, and is more stock on the way?");

    io:println("Query: ", trace.userMessage.content);
    io:println("Iterations: ", trace.iterations.length());
    foreach int i in 0 ..< trace.iterations.length() {
        ai:Iteration iteration = trace.iterations[i];
        io:println(string `Iteration ${i + 1}:`);
        foreach ai:ChatAssistantMessage|ai:ChatFunctionMessage|ai:Error output in iteration.output {
            if output is ai:ChatFunctionMessage {
                // A tool was called; the content is the result returned by the tool.
                io:println(string `  Tool '${output.name}' returned: ${output.content ?: ""}`);
            } else if output is ai:ChatAssistantMessage {
                io:println("  Assistant: ", output.content ?: "");
            } else {
                io:println("  Error: ", output.message());
            }
        }
    }

    ai:FunctionCall[] toolCalls = trace.toolCalls ?: [];
    io:println("Tool calls: ", toolCalls.map(toolCall => toolCall.name));

    ai:ChatAssistantMessage|ai:Error output = trace.output;
    io:println("Final answer: ", output is ai:ChatAssistantMessage ? output.content ?: "" : output.message());
    io:println("Duration: ", time:utcDiffSeconds(trace.endTime, trace.startTime), "s");
}
