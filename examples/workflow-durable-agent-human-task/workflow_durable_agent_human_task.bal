import ballerina/io;
import ballerina/log;
import ballerina/workflow;
// Serves the workflow management REST API, which lists and completes tasks.
import ballerina/workflow.management.rest as _;
import ballerinax/ai.openai;

configurable string openAiApiKey = ?;

type Approval record {|
    boolean approved;
|};

# Issues a refund for an order.
# + orderId - The order ID
# + return - The refund status
@workflow:Activity
function issueRefund(string orderId) returns string|error {
    log:printInfo("Issuing refund", orderId = orderId);
    return "REFUNDED";
}

final workflow:DurableAgent refundAgent = check new ({
    systemPrompt: {
        role: "Refund assistant",
        instructions: string `Get approval with the approveRefund tool first.
            Issue the refund only if it is approved.`
    },
    model: check new openai:ModelProvider(openAiApiKey, openai:GPT_4O_MINI),
    activities: [issueRefund],
    // Human tasks also become tools. When the model calls one, the agent
    // pauses durably until a person completes the task.
    humanTasks: {
        approveRefund: {
            userRoles: "manager",
            resultType: Approval,
            title: "Approve the refund"
        }
    }
});

public function main() returns error? {
    string id = check refundAgent.run("Refund order ORD-001.");
    io:println("Agent started: ", id);

    // Wait until a manager completes the task and the agent finishes.
    string answer = check refundAgent.waitForResult(id);
    io:println(answer);
}
