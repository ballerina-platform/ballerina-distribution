import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

public function main(string subject) returns error? {
    // Create a user message with the prompt as the content.
    ai:ChatUserMessage userMessage = {
        role: ai:USER,
        content: `Tell me a joke about ${subject}!`
    };

    // Use an array to hold the conversation history.
    ai:ChatMessage[] messages = [userMessage];

    // Use the `chat` method to make a call with the conversation history.
    // Alternatively, you can pass a single message (`userMessage`) too.
    ai:ChatAssistantMessage assistantMessage = check model->chat(messages);

    // Update the conversation history with the assistant's response.
    messages.push(assistantMessage);

    // Print the joke from the assistant's response.
    string? joke = assistantMessage?.content;
    io:println(joke);

    // Continue the conversation by asking for an explanation.
    messages.push({
        role: ai:USER,
        content: "Can you explain it?"
    });
    ai:ChatAssistantMessage assistantMessage2 = check model->chat(messages);

    // Since the conversation history is passed, the model can provide a relevant explanation.
    string? explanation = assistantMessage2?.content;
    io:println(explanation);
}
