import ballerina/ai;
import ballerina/io;
import ballerinax/ai.ollama;

// The name of a model already pulled into your local Ollama server (e.g., `ollama pull llama3.2`).
configurable string ollamaModel = "llama3.2";
// The URL of the local Ollama server. Override it in the `Config.toml` file if required.
configurable string ollamaServiceUrl = "http://localhost:11434";

// Initialize a model provider for a model running locally via Ollama.
// Since no API key is required, this is useful for local development and
// for running models on your own infrastructure.
final ai:ModelProvider model = check new ollama:ModelProvider(ollamaModel, ollamaServiceUrl);

type CityInfo record {|
    # The country the city is in
    string country;
    # What the city is best known for, in one short phrase
    string knownFor;
|};

public function main(string city) returns error? {
    // Use the `generate` method to bind the model's response to a structured type.
    CityInfo cityInfo = check model->generate(`Which country is ${city} in and what is it best known for?`);
    io:println("Country: ", cityInfo.country);
    io:println("Known for: ", cityInfo.knownFor);
}
