import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;

// The API key for the model provider. Add it to the `Config.toml` file.
configurable string openAiApiKey = ?;

final ai:ModelProvider model = check new openai:ModelProvider(openAiApiKey, openai:GPT_5_MINI,
        // Use the Responses API.
        apiType = openai:RESPONSES);

type Summary record {|
    # A short title for the text
    string title;
    # The key points, one sentence each
    string[] keyPoints;
|};

public function main() returns error? {
    string text = string `Ballerina is an open-source, cloud-native programming language
        optimized for integration. It has first-class support for network protocols, data
        formats such as JSON and XML, and concurrency. The language also provides built-in
        abstractions to work with large language models, agents, and retrieval-augmented
        generation.`;

    // Since the provider implements `ai:ModelProvider`, the `generate` method works exactly
    // the same as with the default model provider. The response is bound to the expected type.
    Summary summary = check model->generate(`Summarize the following text: ${text}`);
    io:println("Title: ", summary.title);
    foreach string keyPoint in summary.keyPoints {
        io:println("- ", keyPoint);
    }
}
