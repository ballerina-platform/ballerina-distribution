import ballerina/ai;
import ballerina/io;
import ballerinax/ai.sqlite;

// Use a persistent short-term memory store, so that the conversation history survives
// restarts and can be shared by multiple instances of the agent. This example uses SQLite
// via the `ballerinax/ai.sqlite` module, which runs in-process and needs no external service.
// Stores backed by PostgreSQL, Redis, Microsoft SQL Server, and Amazon DynamoDB are also available.
final sqlite:ShortTermMemoryStore store = check new ({url: "jdbc:sqlite:./agent_memory.db"},
        // The maximum number of messages retained per session.
        maxMessagesPerKey = 30);

final ai:Memory memory = check new ai:ShortTermMemory(store);

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Assistant",
        instructions: string `You help customers with their orders. Remember the details
            the customer shares and use them in later answers. Keep answers brief.`
    },
    model: check ai:getDefaultModelProvider(),
    memory
});

public function main() returns error? {
    string sessionId = "customer-42";
    string response = check supportAgent.run(
            "Hi, my order number is ORD-7781 and it hasn't arrived yet.", sessionId);
    io:println(response);
    response = check supportAgent.run("What was my order number again?", sessionId);
    io:println(response);

    // The messages are persisted in the database, so they survive restarts of the program
    // and are available to other instances of the agent that use the same store.
    ai:ChatMessage[] messages = check memory.get(sessionId);
    io:println("\nMessages stored for session 'customer-42': ", messages.length(),
            " ", messages.map(message => message.role.toString()));
}
