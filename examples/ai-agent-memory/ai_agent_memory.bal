import ballerina/ai;
import ballerina/io;

// By default, an agent uses in-memory short-term memory with a fixed capacity. Configure the
// memory explicitly to control the capacity (messages retained per session), the store, or
// the overflow handling.
final ai:Memory memory = check new ai:ShortTermMemory(check new ai:InMemoryShortTermMemoryStore(20));

final ai:Agent travelAgent = check new ({
    systemPrompt: {
        role: "Travel Assistant",
        instructions: string `You help users plan trips. Remember the details the user
            shares and use them in later answers. Keep answers to two sentences.`
    },
    model: check ai:getDefaultModelProvider(),
    memory
});

public function main() returns error? {
    // Messages exchanged in a session are stored in memory against the session ID,
    // so the agent can use the earlier context to answer follow-up questions.
    string sessionId = "user-1";
    string response = check travelAgent.run(
            "I'm planning a 5-day trip to Japan in April with my two kids.", sessionId);
    io:println(response);
    response = check travelAgent.run(
            "Suggest one activity for the trip that suits the people travelling.", sessionId);
    io:println(response);

    // Each session has its own memory. A different session does not have access
    // to the conversation above.
    response = check travelAgent.run("Where am I planning to travel?", "user-2");
    io:println(response);

    // The stored messages can be retrieved using the memory instance. After two turns, the memory of
    // the first session holds 5 messages: the system message, 2 user messages, and 2 assistant messages.
    ai:ChatMessage[] messages = check memory.get(sessionId);
    io:println("\nMessages stored for session 'user-1': ", messages.length(),
            " ", messages.map(message => message.role.toString()));

    // Deleting a session clears only that session; other sessions are not affected.
    check memory.delete(sessionId);
    messages = check memory.get(sessionId);
    io:println("Messages stored for session 'user-1' after deletion: ", messages.length());
    messages = check memory.get("user-2");
    io:println("Messages stored for session 'user-2': ", messages.length(),
            " ", messages.map(message => message.role.toString()));
}
