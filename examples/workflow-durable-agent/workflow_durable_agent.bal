import ballerina/io;
import ballerina/log;
import ballerina/workflow;
import ballerinax/ai.openai;

configurable string openAiApiKey = ?;

# Checks whether an item is in stock.
# + item - The item name
# + return - Whether the item is in stock
@workflow:Activity
function checkStock(string item) returns boolean|error {
    log:printInfo("Checking stock", item = item);
    return true;
}

// A durable agent runs as a workflow. The runtime records every model call
// and tool call, so the agent resumes after a crash without repeating them.
final workflow:DurableAgent stockAgent = check new ({
    systemPrompt: {
        role: "Stock assistant",
        instructions: "Answer questions about item stock."
    },
    model: check new openai:ModelProvider(openAiApiKey, openai:GPT_4O_MINI),
    // Activities become tools that the model can call. The doc comment of
    // the activity describes the tool to the model.
    activities: [checkStock]
});

public function main() returns error? {
    // Start the agent with a query. This returns the instance ID.
    string id = check stockAgent.run("Is the laptop in stock?");

    // Wait for the agent to finish and read its answer.
    string answer = check stockAgent.waitForResult(id);
    io:println(answer);
}
