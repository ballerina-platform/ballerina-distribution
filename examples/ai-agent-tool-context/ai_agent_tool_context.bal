import ballerina/ai;
import ballerina/io;

type Order record {|
    string id;
    string customerId;
    string status;
|};

final readonly & Order[] orders = [
    {id: "ORD-1001", customerId: "CUST-7", status: "delivered"},
    {id: "ORD-1002", customerId: "CUST-9", status: "in transit"},
    {id: "ORD-1003", customerId: "CUST-7", status: "processing"}
];

// A tool that does not accept the context. It only has the parameters the LLM provides,
// so its whole signature appears in the tool schema sent to the LLM.
# Gets the shipping options available for a country.
# + country - The destination country
# + return - The available shipping options
@ai:AgentTool
isolated function getShippingOptions(string country) returns string[] {
    return country == "Sri Lanka" ? ["Standard (3-5 days)", "Express (1 day)"] : ["International (7-14 days)"];
}

// A tool that accepts only the context. The `ai:Context` parameter is left out of the tool
// schema, so the LLM sees a tool with no parameters and cannot choose the customer.
# Lists the orders of the signed-in customer.
# + context - The context carrying the ID of the signed-in customer
# + return - The orders of the customer
@ai:AgentTool
isolated function listMyOrders(ai:Context context) returns Order[]|error {
    // Read the value that the caller placed in the context.
    string customerId = check context.getWithType("customerId");
    return from Order 'order in orders
        where 'order.customerId == customerId
        select 'order;
}

// A tool that accepts the context along with other parameters. The `ai:Context` parameter
// must be the first parameter and is left out of the tool schema; only `orderId` and `reason`
// are sent to the LLM, which supplies their values from the conversation.
# Cancels an order of the signed-in customer.
# + context - The context carrying the ID of the signed-in customer
# + orderId - The ID of the order to cancel
# + reason - The reason for the cancellation
# + return - A confirmation message, or an error if the order does not belong to the customer
@ai:AgentTool
isolated function cancelOrder(ai:Context context, string orderId, string reason) returns string|error {
    string customerId = check context.getWithType("customerId");
    Order[] matching = from Order 'order in orders
        where 'order.id == orderId && 'order.customerId == customerId
        select 'order;
    if matching.length() == 0 {
        return error(string `Order ${orderId} was not found for the signed-in customer`);
    }
    return string `Order ${orderId} has been cancelled. Reason recorded: ${reason}`;
}

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: "You answer questions about the orders of the signed-in customer. Keep answers brief."
    },
    model: check ai:getDefaultModelProvider(),
    tools: [getShippingOptions, listMyOrders, cancelOrder]
});

public function main() returns error? {
    // The ID of the signed-in customer comes from the application, not from the conversation,
    // so it is passed through the context rather than the query.
    ai:Context context = new;
    context.set("customerId", "CUST-7");
    string sessionId = "customer-7";
    string response = check supportAgent.run("What is the status of my orders?", sessionId, context);
    io:println(response);

    // The LLM provides the order ID and the reason; the customer ID still comes from the context.
    response = check supportAgent.run("Cancel order ORD-1003, I ordered it by mistake.", sessionId, context);
    io:println("\n", response);

    // This question is answered with the tool that does not use the context.
    response = check supportAgent.run("Which shipping options do you offer for Sri Lanka?", sessionId, context);
    io:println("\n", response);

    // The same agent serves another customer by running it with a different context.
    ai:Context otherContext = new;
    otherContext.set("customerId", "CUST-9");
    response = check supportAgent.run("What is the status of my orders?", "customer-9", otherContext);
    io:println("\n", response);
}
