import ballerina/ai;
import ballerina/ai.eval;
import ballerina/test;

// Use the default model provider (with configuration added via a Ballerina VS Code command)
// for both the agent under test and the judge model.
final ai:ModelProvider model = check ai:getDefaultModelProvider();

# Converts an amount from one currency to another.
# + amount - The amount to convert
# + fromCurrency - The source currency code (e.g., USD)
# + toCurrency - The target currency code (e.g., EUR)
# + return - The converted amount
@ai:AgentTool
isolated function convertCurrency(decimal amount, string fromCurrency, string toCurrency) returns decimal {
    if fromCurrency == "USD" && toCurrency == "EUR" {
        return amount * 0.92d;
    }
    return amount;
}

final ai:Agent financeAgent = check new ({
    systemPrompt: {
        role: "Finance Assistant",
        instructions: "You answer currency questions using the tools. Be concise and state the converted amount."
    },
    model,
    tools: [convertCurrency]
});

// Rule-based evaluation: the agent must answer within the given number of
// reasoning-action cycles.
@test:Config {}
function testIterationEfficiency() returns error? {
    check eval:assertIterationEfficiency(financeAgent, "Convert 100 USD to EUR.", maxIterations = 3);
}

// Rule-based evaluation: the response must contain the expected content.
@test:Config {}
function testContentCoverage() returns error? {
    check eval:assertContentCoverage(financeAgent, "Convert 100 USD to EUR.", ["92"]);
}

// LLM-as-a-judge evaluation: a judge model scores the helpfulness of the response,
// and the evaluation passes when the score reaches the threshold.
@test:Config {}
function testHelpfulness() returns error? {
    check eval:evaluateHelpfulness(financeAgent, "Convert 100 USD to EUR.",
            judgeModel = model, judgeScoreThreshold = 0.7);
}
