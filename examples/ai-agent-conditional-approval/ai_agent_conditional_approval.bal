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

// A per-call approval rule. It is written with the exact same parameter signature
// as the tool it gates, so the agent binds the proposed call's arguments to it by
// name. Only the calls it returns `true` for pause for approval. The rule must be
// `isolated` and deterministic given its arguments.
isolated function largeTransfer(string fromAccount, string toAccount, decimal amount)
        returns boolean => amount > 500d;

// A sensitive tool that moves money. `requiresApproval` accepts a function as well
// as a plain `true`/`false`. Here, small transfers run straight through while
// anything above the threshold pauses for a human decision, so reviewers only see
// the transfers that actually carry risk.
@ai:AgentTool {requiresApproval: largeTransfer}
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

// Define an AI agent that gates only its large transfers.
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

        // Small transfers complete without pausing; only a large transfer makes
        // `run` return an `ai:ApprovalRequiredError`.
        string|ai:Error result = bankingAgent.run(userInput, sessionId);

        while result is ai:ApprovalRequiredError {
            map<ai:HumanResponse> decisions = {};
            foreach ai:ApprovalRequest request in result.detail().requests {
                io:println(string `Approval needed for '${request.toolName}' ` +
                    string `with ${request.arguments.toString()}`);
                string answer = io:readln("Approve? (yes/no): ");
                decisions[request.id] = answer == "yes"
                    ? {decision: ai:APPROVE}
                    : {decision: ai:REJECT, reason: "Not authorized by the reviewer."};
            }
            // Resume the paused run with the collected decisions.
            result = bankingAgent.run({decisions}, sessionId);
        }

        if result is ai:Error {
            return result;
        }
        io:println("Agent: ", result);
    }
}
