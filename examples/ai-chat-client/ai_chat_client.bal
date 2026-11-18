import ballerina/ai;
import ballerina/io;

public function main() returns error? {
    // Create a chat client for a chat agent service exposed via an `ai:Listener`.
    // This example connects to the service from the Chat agents example.
    ai:ChatClient chatClient = check new ("http://localhost:8080/tasks");

    // Each conversation is identified by a session ID, which the service uses
    // to keep the conversation history in the agent's memory.
    string sessionId = "user-1";

    // Send a chat message. The response contains the agent's reply.
    ai:ChatRespMessage response = check chatClient->/chat.post({
        sessionId,
        message: "Add a task to renew my passport by the end of this month."
    });
    io:println("Agent: ", response.message);

    // Follow-up messages in the same session have access to the earlier context.
    response = check chatClient->/chat.post({
        sessionId,
        message: "What tasks do I have?"
    });
    io:println("Agent: ", response.message);
}
