import ballerina/ai;
import ballerina/io;

enum Priority {
    LOW,
    MEDIUM,
    HIGH
}

// The structured result that every agent created from the definition returns.
type Triage record {|
    string category;
    Priority priority;
    string summary;
|};

# Gets the support tier of a customer.
# + customerId - The ID of the customer
# + return - The support tier of the customer
@ai:AgentTool
isolated function getSupportTier(string customerId) returns string =>
    customerId.startsWith("ENT-") ? "enterprise" : "standard";

# An agent definition that triages support requests for a product.
public isolated class SupportTriageAgent {
    // Including `ai:FixedTypedAgent` makes the class an agent definition with a fixed return type.
    *ai:FixedTypedAgent;

    private final ai:Agent agent;

    # Initializes an agent from the definition.
    # + model - The model provider to use
    # + memory - The memory to use, or `()` for a stateless agent
    # + product - The product that the agent triages requests for
    # + categories - The categories that the agent assigns requests to
    public function init(ai:ModelProvider model, ai:Memory? memory = (), string product = "",
            string[] categories = ["Bug", "Outage", "Question"]) returns error? {
        // The role, instructions, and tools are part of the definition. The model, the
        // memory, the product, and the categories vary between the agents created from it.
        self.agent = check new (
            systemPrompt = {
                role: string `Support Triage Agent for ${product}`,
                instructions: string `You triage support requests for ${product}. Assign each
                    request to one of these categories: ${", ".'join(...categories)}. Set the
                    priority to HIGH for outages, to MEDIUM for other requests of enterprise
                    customers, and to LOW otherwise. Summarize the request in one sentence.`
            },
            model = model,
            memory = memory,
            tools = [getSupportTier]
        );
    }

    // Runs the agent and returns the triage result.
    public isolated function run(string|ai:Prompt query,
            string sessionId = "sessionId",
            ai:Context context = new) returns Triage|ai:Error {
        return self.agent.run(query, sessionId, context);
    }

    // Runs the agent and returns the execution trace instead of the result.
    public isolated function trace(string|ai:Prompt query,
            string sessionId = "sessionId",
            ai:Context context = new) returns ai:Trace|ai:Error {
        return self.agent.run(query, sessionId, context);
    }
}

public function main() returns error? {
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    ai:ModelProvider model = check ai:getDefaultModelProvider();

    // Create two agents from the same definition, one for each product.
    SupportTriageAgent paymentsTriageAgent = check new (model, product = "Acme Payments");
    SupportTriageAgent analyticsTriageAgent = check new (model, product = "Acme Analytics",
        categories = ["Bug", "Outage", "How-to", "Feature request"]);

    Triage paymentsTriage = check paymentsTriageAgent.run(
        "Customer ENT-204: all card payments have been failing since 9 AM.");
    io:println("Acme Payments: ", paymentsTriage);

    Triage analyticsTriage = check analyticsTriageAgent.run(
        "Customer C-881: how do I change the color of a chart?");
    io:println("Acme Analytics: ", analyticsTriage);

    // The trace shows the tool calls that the agent made to reach the result.
    ai:Trace trace = check analyticsTriageAgent.trace(
        "Customer C-881: how do I change the color of a chart?");
    ai:FunctionCall[] toolCalls = trace.toolCalls ?: [];
    io:println("Tool calls: ", from ai:FunctionCall call in toolCalls select call.name);
}
