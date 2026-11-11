import ballerina/ai;
import ballerina/io;
import ballerinax/ai.anthropic;

// The API key for the model provider. Add it to the `Config.toml` file.
configurable string anthropicApiKey = ?;

// Initialize a model provider for a specific LLM provider using your own API key.
// This example uses Anthropic via the `ballerinax/ai.anthropic` module. Any
// `ai:ModelProvider` implementation can be used with natural expressions.
final ai:ModelProvider model = check new anthropic:ModelProvider(anthropicApiKey,
                                                                anthropic:CLAUDE_SONNET_4_5);

# Represents a book recommendation.
type Book record {|
    # The title of the book
    string title;
    # The author of the book
    string author;
    # A one-sentence reason for the recommendation
    string reason;
|};

public function main() returns error? {
    // Specify the model provider as the argument to the natural expression.
    // The JSON schema generated for the expected type (`Book[]`) is used in the
    // request to the LLM, and the result is automatically bound to the type.
    Book[] books = check natural (model) {
        Recommend 3 classic science fiction books for someone who
        enjoys stories about first contact with alien civilizations.
    };

    foreach Book book in books {
        io:println(book.title, " by ", book.author);
        io:println("  ", book.reason);
    }
}
