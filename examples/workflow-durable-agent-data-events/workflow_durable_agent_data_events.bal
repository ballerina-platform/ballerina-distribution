import ballerina/io;
import ballerina/workflow;
import ballerinax/ai.openai;

configurable string openAiApiKey = ?;

final workflow:DurableAgent chatAgent = check new ({
    systemPrompt: {
        role: "Chat assistant",
        instructions: "Answer in one short sentence."
    },
    model: check new openai:ModelProvider(openAiApiKey, openai:GPT_4O_MINI),
    // A data event channel. Each `chat` event is one turn with a `string`
    // reply. The agent keeps the conversation between turns.
    events: {
        chat: {request: string, response: string}
    }
});

public function main() returns error? {
    // Start the agent. It waits for events on its channels.
    string id = check chatAgent.run("");

    foreach string message in ["Hi, I am Alice.", "What is my name?"] {
        // Send an event. This returns a token for the reply of this turn.
        string token = check chatAgent.sendData(id, "chat", message);
        string reply = check chatAgent.waitForDataResult(id, token);
        io:println(reply);
    }
}
