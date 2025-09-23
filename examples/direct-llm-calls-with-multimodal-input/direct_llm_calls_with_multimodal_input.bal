import ballerina/ai;
import ballerina/io;
import ballerinax/ai.anthropic;

// Use `configurable` variables for the model name and API key.
configurable anthropic:ANTHROPIC_MODEL_NAMES modelType = ?;
configurable string apiKey = ?;

// Create a model provider to interact with the Anthropic API.
// The `temperature` parameter is optional, and defaults to 0.7 if not specified.
final ai:ModelProvider model =
    check new anthropic:ModelProvider(apiKey, modelType, temperature = 0);

// The type representing the expected response from the model.
// The generated JSON schema will also include the documentation.
# Description of an image.
type Description record {|
    # A sentence describing the image.
    string description;
    # The confidence of the description, on a scale of 0 to 1.
    decimal confidence;
    # Categories that the image falls into.
    string[] categories;
|};

public function main() returns error? {
    // Define an `ai:ImageDocument` value with a URL to an image.
    ai:ImageDocument image = {
        content: "https://ballerina.io/img/branding/ballerina_logo_dgrey_png.png"
    };

    // Use the `generate` method with an image document as an interpolation.
    // `anthropic:ModelProvider` will detect the multimodal input and handle
    // constructing the request appropriately.
    Description? description = check model->generate(`
        Describe this image.

        ${image}
        
        If it is not possible to describe the image, respond with null`);

    // Handle the case where the model could not describe the image.
    if description is () {
        io:println("Could not describe the image");
        return;
    }
    
    // Print the description.
    io:println(description);
}
