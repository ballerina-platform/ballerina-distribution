import ballerina/ai;
import ballerina/io;
import ballerina/time;

type ReturnEligibility record {|
    boolean eligible;
    string reason;
|};

# Gets the status of an order.
# + orderId - The ID of the order
# + return - The status of the order
@ai:AgentTool
isolated function getOrderStatus(string orderId) returns string =>
    orderId == "ORD-1001" ? "Delivered on 2026-09-20" : "Not found";

# Gets the category of the product in an order.
# + orderId - The ID of the order
# + return - The product category
@ai:AgentTool
isolated function getProductCategory(string orderId) returns string =>
    orderId == "ORD-1001" ? "electronics" : "unknown";

# Counts the days between two dates.
# + fromDate - The start date in the `YYYY-MM-DD` format
# + toDate - The end date in the `YYYY-MM-DD` format
# + return - The number of days from the start date to the end date
@ai:AgentTool
isolated function daysBetween(string fromDate, string toDate) returns int|error {
    time:Utc 'from = check time:utcFromString(fromDate + "T00:00:00Z");
    time:Utc to = check time:utcFromString(toDate + "T00:00:00Z");
    return <int>(time:utcDiffSeconds(to, 'from) / 86400);
}

final ai:ModelProvider model = check ai:getDefaultModelProvider();

// A specialist agent that looks up orders. It is configured with `memory: ()`, so it is
// stateless and keeps no conversation history between delegations.
final ai:Agent orderAgent = check new ({
    systemPrompt: {
        role: "Order Specialist",
        instructions: "You look up the status and the product category of orders using the tools."
    },
    model,
    tools: [getOrderStatus, getProductCategory],
    memory: ()
});

// A specialist agent that applies the returns policy, with its own tool and instructions.
final ai:Agent returnsPolicyAgent = check new ({
    systemPrompt: {
        role: "Returns Policy Specialist",
        instructions: string `You decide whether an item can be returned. Electronics can be
            returned within 14 days of delivery, and other items within 30 days. Use the tool
            to count the days since the delivery.`
    },
    model,
    tools: [daysBetween],
    memory: ()
});

// An agent becomes a tool of another agent through a function that runs it. The calling agent
// decides when to call the tool and composes the query, so the description says when to use
// it and what the query must include, since the sub-agent cannot see the conversation.

# Delegates questions about the status or the product category of an order to the order
# specialist. Include the order ID in the query.
# + query - A self-contained request for the order specialist
# + return - The response from the order specialist
@ai:AgentTool
isolated function orderAgentTool(string query) returns string|error {
    io:println("[Delegating to the order specialist] ", query);
    return orderAgent.run(query);
}

# Delegates the decision of whether an item can be returned to the returns policy specialist.
# Call it only after the order specialist has provided the product category and the delivery
# date, and include them and today's date in the query.
# + query - A self-contained request for the returns policy specialist
# + return - Whether the item can be returned, and the reason
@ai:AgentTool
isolated function returnsPolicyAgentTool(string query) returns ReturnEligibility|error {
    io:println("[Delegating to the returns policy specialist] ", query);
    // The return type of the tool binds the response of the sub-agent to a structured type,
    // so the calling agent receives a result that needs no further interpretation.
    return returnsPolicyAgent.run(query);
}

// The orchestrator owns the conversation, delegates the subtasks to the specialists, and
// composes the final answer.
final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: string `You help customers with their orders. Never assume order details:
            get them from the order specialist first. Delegate return decisions to the returns
            policy specialist with the details you got, then answer the customer briefly.
            Today is 2026-09-28.`
    },
    model,
    tools: [orderAgentTool, returnsPolicyAgentTool]
});

public function main() returns error? {
    string response = check supportAgent.run("Can I still return my order ORD-1001?");
    io:println("Agent: ", response);
}
