import ballerina/ai;
import ballerina/io;

type Order record {|
    string id;
    decimal total;
    string status;
|};

isolated map<Order> orders = {
    "ORD-1001": {id: "ORD-1001", total: 120.50, status: "delivered"}
};

# Gets the details of an order.
# + orderId - The order ID
# + return - The order details, or an error if the order is not found
@ai:AgentTool
isolated function getOrder(string orderId) returns Order|error {
    lock {
        Order? 'order = orders[orderId];
        if 'order is () {
            return error("Order not found: " + orderId);
        }
        return 'order.clone();
    }
}

// The agent pauses before calling this tool and waits for a human decision.
# Issues a refund for an order. This action is irreversible.
# + orderId - The order ID
# + amount - The amount to refund
# + return - A confirmation message, or an error if the order is not found
@ai:AgentTool {requiresApproval: true}
isolated function issueRefund(string orderId, decimal amount) returns string|error {
    lock {
        Order? 'order = orders[orderId];
        if 'order is () {
            return error("Order not found: " + orderId);
        }
        'order.status = "refunded";
    }
    return string `A refund of ${amount} has been issued for order ${orderId}`;
}

// Decides per call from the proposed arguments: discounts above 10% need approval.
isolated function needsApproval(string orderId, int percent) returns boolean => percent > 10;

# Applies a discount to an order.
# + orderId - The order ID
# + percent - The discount percentage
# + return - A confirmation message
@ai:AgentTool {requiresApproval: needsApproval}
isolated function applyDiscount(string orderId, int percent) returns string =>
    string `A ${percent}% discount has been applied to order ${orderId}`;

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: string `You help customers with their orders. Look up orders, and
            apply discounts and issue refunds when asked. Keep answers brief.`
    },
    model: check ai:getDefaultModelProvider(),
    tools: [getOrder, issueRefund, applyDiscount]
});

public function main() returns error? {
    // A 5% discount does not need approval, so the agent applies it directly.
    check chat("Please apply a 5% discount to my order ORD-1001.");
    // A refund always needs approval.
    check chat("Please refund my order ORD-1001 in full.");
}

function chat(string query) returns error? {
    string sessionId = "customer-7";
    string|ai:Error result = supportAgent.run(query, sessionId);

    // The run pauses with an `ai:ApprovalRequiredError` that lists the pending tool calls.
    if result is ai:ApprovalRequiredError {
        map<ai:HumanDecision> decisions = {};
        foreach ai:ApprovalRequest request in result.detail().requests {
            io:println(string `Approval required to call '${request.toolName}' with arguments ${
                    request.arguments.toJsonString()}`);
            // Read the decision from the console.
            string answer = io:readln("Approve? (y/n): ");
            decisions[request.id] = answer.toLowerAscii() == "y" ?
                    {outcome: ai:APPROVE} :
                    {outcome: ai:REJECT, reason: "Rejected by the support supervisor"};
        }

        // Resume the run with the decisions, using the same session ID.
        ai:Resume resume = {decisions: decisions.cloneReadOnly()};
        string response = check supportAgent.run(resume, sessionId);
        io:println("Agent: ", response);
    } else {
        io:println("Agent: ", check result);
    }
}
