import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

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
    // The model provider implementation will detect the multimodal input and handle
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
