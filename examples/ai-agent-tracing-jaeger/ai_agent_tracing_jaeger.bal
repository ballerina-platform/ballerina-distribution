import ballerina/ai;
import ballerina/http;
// Import the Jaeger extension to send the traces to Jaeger.
import ballerinax/jaeger as _;

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

service /inventory on new ai:Listener(8080) {
    // No tracing code is needed. With tracing turned on, each agent run is sent to Jaeger.
    resource function post chat(@http:Payload ai:ChatReqMessage request)
            returns ai:ChatRespMessage|error {
        string response = check inventoryAgent.run(request.message, request.sessionId);
        return {message: response};
    }
}
