import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

# Represents a tourist attraction.
type Attraction record {|
    # The name of the attraction
    string name;
    # The city where the attraction is located
    string city;
    # A notable feature or highlight of the attraction
    string highlight;
|};

function getAttractions(int count, string country, string interest) 
                            returns Attraction[]|error {
    // Use a natural expression to get attractions.
    // The JSON schema generated for the expected type (`Attraction[]`) is 
    // used in the request to the large language model, and the
    // result is automatically parsed into an array of `Attraction` records.
    Attraction[]|error attractions = 
        // Specify the model provider in the natural expression.
        // Use insertions to insert expressions (e.g., parameters) into the prompt.
        natural (model) {
            Give me the top ${count} tourist attractions in ${country} 
            for visitors interested in ${interest}. 
            
            For each attraction, the highlight should be one sentence
            describing what makes it special or noteworthy.
        };
    return attractions;
}

public function main() returns error? {
    Attraction[] attractions = check getAttractions(3, "Sri Lanka", "Wildlife");
    foreach Attraction attraction in attractions {
        io:println("Name: ", attraction.name);
        io:println("City: ", attraction.city);
        io:println("Highlight: ", attraction.highlight, "\n");
    }
}
