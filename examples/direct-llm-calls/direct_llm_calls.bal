import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

type JokeResponse record {|
    string setup;
    string punchline;
|};

public function main(string subject) returns error? {
    // Use an insertion to insert the subject into the prompt.
    // The response is expected to be a string.
    string joke = check model->generate(`Tell me a joke about ${subject}!`);
    io:println(joke);

    // An LLM call with a structured response type.
    JokeResponse jokeResponse = check model->generate(`Tell me a joke about ${subject}!`);
    io:println("Setup: ", jokeResponse.setup);
    io:println("Punchline: ", jokeResponse.punchline);
}
