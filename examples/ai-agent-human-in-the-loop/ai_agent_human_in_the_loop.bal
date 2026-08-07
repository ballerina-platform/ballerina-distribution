import ballerina/ai;
import ballerina/io;

type Account record {|
    string id;
    string owner;
    decimal balance;
|};

// Simple in-memory account store.
isolated map<Account> accounts = {
    "ACC-1001": {id: "ACC-1001", owner: "Alice", balance: 1000.00},
    "ACC-1002": {id: "ACC-1002", owner: "Bob", balance: 250.00}
};

// A read-only tool. The agent may call this freely, without approval.
@ai:AgentTool
isolated function checkBalance(string accountId) returns decimal|error {
    lock {
        Account? account = accounts[accountId];
        if account is () {
            return error(string `No account found with the ID '${accountId}'.`);
        }
        return account.balance;
    }
}

// A sensitive tool that moves money. Setting `requiresApproval` to `true` makes
// the agent pause and request human approval before this function is ever invoked.
@ai:AgentTool {requiresApproval: true}
isolated function transfer(string fromAccount, string toAccount, decimal amount)
        returns string|error {
    lock {
        Account? sender = accounts[fromAccount];
        Account? recipient = accounts[toAccount];
        if sender is () || recipient is () {
            return error("One or both accounts were not found.");
        }
        if sender.balance < amount {
            return error(string `Insufficient funds in account '${fromAccount}'.`);
        }
        // Debit the sender and credit the recipient.
        accounts[fromAccount] = {id: sender.id, owner: sender.owner, balance: sender.balance - amount};
        accounts[toAccount] = {id: recipient.id, owner: recipient.owner, balance: recipient.balance + amount};
    }
    return string `Transferred ${amount} from ${fromAccount} to ${toAccount}.`;
}

// Define an AI agent whose money-moving tool requires human approval.
final ai:Agent bankingAgent = check new ({
    systemPrompt: {
        role: "Banking Assistant",
        instructions: string `You help users check balances and transfer money
            between accounts. Always confirm the details before a transfer.`
    },
    // Specify the functions the agent can use as tools.
    tools: [checkBalance, transfer],
    // Use the default model provider (with configuration added
    // via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider()
});

public function main() returns error? {
    // A stable session ID lets the agent resume the same paused run after approval.
    string sessionId = "banking-session";
    while true {
        string userInput = io:readln("User (or 'exit' to quit): ");
        if userInput == "exit" {
            break;
        }

        // If the agent decides to call a tool that requires approval, `run` returns
        // an `ai:ApprovalRequiredError` instead of executing the tool.
        string|ai:Error result = bankingAgent.run(userInput, sessionId);

        // The agent can pause more than once in a single logical run, so keep
        // resolving pending approvals until the run produces a final answer.
        while result is ai:ApprovalRequiredError {
            // Each pause carries one request per gated tool call awaiting a decision.
            ai:ApprovalRequest[] requests = result.detail().requests;
            map<ai:HumanResponse> decisions = {};
            foreach ai:ApprovalRequest request in requests {
                io:println(string `Approval needed for '${request.toolName}' ` +
                    string `with ${request.arguments.toString()}`);
                string answer = io:readln("Approve? (yes/no): ");
                // Decisions are keyed by each request's `id`. Approve the call as-is,
                // or reject it with an optional reason the agent can use to replan.
                decisions[request.id] = answer == "yes"
                    ? {decision: ai:APPROVE}
                    : {decision: ai:REJECT, reason: "Not authorized by the reviewer."};
            }
            // Resume the paused run by passing the decisions back to `run`. The input
            // type (`ai:Resume`) is what distinguishes a resume from a new query.
            result = bankingAgent.run({decisions}, sessionId);
        }

        if result is ai:Error {
            return result;
        }
        io:println("Agent: ", result);
    }
}
