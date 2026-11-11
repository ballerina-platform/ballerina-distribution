import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

public function main() returns error? {
    string query = "How many days of annual leave can I carry forward, and by when must I use them?";

    // The chunks retrieved for the query from a knowledge base or a vector store. They are
    // defined inline here to focus on the augmentation step; see the retrieval examples for
    // how they are retrieved.
    ai:QueryMatch[] retrievedContext = [
        {chunk: <ai:TextChunk>{content: "Unused annual leave of up to 5 days can be carried forward to the next year."},
            similarityScore: 0.82},
        {chunk: <ai:TextChunk>{content: "Carried-forward leave must be used before the end of March."},
            similarityScore: 0.79},
        {chunk: <ai:TextChunk>{content: "Employees are entitled to 10 days of paid sick leave per year."},
            similarityScore: 0.41}
    ];

    // Option 1: use `ai:augmentUserQuery` to build a user message that combines the retrieved
    // context and the query using a generic prompt template. Its content is an `ai:Prompt`,
    // which is passed to the `generate` method.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(retrievedContext, query);
    ai:Prompt augmentedPrompt = check augmentedQuery.content.ensureType();
    string response = check model->generate(augmentedPrompt);
    io:println("Answer (augmentUserQuery): ", response);

    // Option 2: write your own prompt with the `generate` method. The retrieved chunks are
    // inserted into the prompt template, and the answer is bound to the expected type, so the
    // prompt can control the tone, the grounding rules, and the output structure.
    ai:Chunk[] chunks = from ai:QueryMatch queryMatch in retrievedContext
        select queryMatch.chunk;
    Answer answer = check model->generate(`You are an HR assistant. Answer the question using
        only the context below. If the context does not contain the answer, set "grounded"
        to false and say that you do not know.

        Context:
        ${chunks}

        Question: ${query}`);
    io:println("\nAnswer (custom prompt): ", answer.text);
    io:println("Grounded in the context: ", answer.grounded);
}

# Represents an answer generated from retrieved context.
type Answer record {|
    # The answer to the question
    string text;
    # Whether the answer is fully supported by the context
    boolean grounded;
|};
