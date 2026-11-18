import ballerina/ai;
import ballerina/io;

final ai:ModelProvider model = check ai:getDefaultModelProvider();

// Short-term memory retains a fixed number of messages per session. When adding a message
// would exceed the capacity, the overflow handler decides what happens to the oldest messages:
// - `ai:TrimOverflowHandlerConfiguration` (the default) removes the oldest messages,
//   e.g., `<ai:TrimOverflowHandlerConfiguration>{trimCount: 2}`.
// - `ai:ModelAssistedOverflowHandlerConfiguration` summarizes the older messages with an LLM
//   into a single message, so their context is retained in condensed form.
final ai:Memory memory = check new ai:ShortTermMemory(check new ai:InMemoryShortTermMemoryStore(6),
        <ai:ModelAssistedOverflowHandlerConfiguration>{model});

final ai:Agent assistant = check new ({
    systemPrompt: {
        role: "Personal Assistant",
        instructions: string `You are a friendly assistant. Remember the details the user
            shares and use them in later answers. Keep answers to one sentence.`
    },
    model,
    memory
});

public function main() returns error? {
    string sessionId = "user-1";
    string response = check assistant.run("My name is Nadia and I live in Lisbon.", sessionId);
    io:println(response);
    response = check assistant.run("I have a cat called Milo.", sessionId);
    io:println(response);

    response = check assistant.run("I work as a marine biologist.", sessionId);
    io:println(response);

    // The three turns produced 7 messages, which exceeds the capacity of the store.
    ai:ChatMessage[] messages = check memory.get(sessionId);
    printMemory(messages);

    // The overflow handler runs before the messages of this turn are added, and replaces the
    // messages above with a single summary. The agent can still use the earlier context,
    // even though the original messages are no longer in memory.
    response = check assistant.run("What do you know about me?", sessionId);
    io:println(response);

    messages = check memory.get(sessionId);
    printMemory(messages);
}

function printMemory(ai:ChatMessage[] messages) {
    io:println("\nMessages in memory: ", messages.length(),
            " ", messages.map(message => message.role.toString()));
    ai:ChatMessage summary = messages[1];
    if summary is ai:ChatAssistantMessage {
        io:println("Summary: ", summary.content, "\n");
    }
}
