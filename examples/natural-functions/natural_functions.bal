import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

# Represents the analysis of a customer review.
type ReviewAnalysis record {|
    # The overall sentiment: "positive", "negative", or "neutral"
    string sentiment;
    # A confidence score between 0 and 1
    float confidence;
    # The main topics mentioned in the review
    string[] topics;
    # A one-sentence summary of the review
    string summary;
|};

// A natural function is a function whose body is a natural expression.
// The function signature is declared in code; the logic is described in natural language.
// The parameters are available in the prompt via interpolations, and the return type
// drives the JSON schema sent to the LLM and the type the response is bound to.
function analyzeReview(string review) returns ReviewAnalysis|error => natural (model) {
    Analyze the following customer review of a hotel stay.

    Identify the overall sentiment, how confident you are, the main topics
    mentioned (e.g., cleanliness, staff, location, price), and provide a
    one-sentence summary.

    Review: ${review}
};

public function main() returns error? {
    string review = string `The room was spotless and the staff went out of their way to
        help us with restaurant bookings. The only downside was the noise from the
        street at night, but the location made up for it.`;

    // Call the natural function like any other function.
    ReviewAnalysis analysis = check analyzeReview(review);
    io:println("Sentiment: ", analysis.sentiment, " (confidence: ", analysis.confidence, ")");
    io:println("Topics: ", analysis.topics);
    io:println("Summary: ", analysis.summary);
}
