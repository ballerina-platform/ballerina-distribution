import ballerina/ai;
import ballerina/io;
import ballerinax/ai.pinecone;

// Configuration for Pinecone.
configurable string pineconeServiceUrl = ?;
configurable string pineconeApiKey = ?;

// Define the vector store to use.
// The example uses Pinecone. Alternatively, you can use other providers
// or try out the in-memory vector store (`ai:InMemoryVectorStore`).
final ai:VectorStore vectorStore = 
            check new pinecone:VectorStore(pineconeServiceUrl, pineconeApiKey);

// Define the embedding provider to use.
// The example uses the default embedding provider implementation
// (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = 
            check ai:getDefaultEmbeddingProvider();

// Create the knowledge base with the vector store and embedding provider.
final ai:KnowledgeBase knowledgeBase = 
            new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

// Define the model provider to use.
// The example uses the default model provider implementation
// (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    string appealQuery = 
        "What is the process for appealing a rejected leave request?";

    // Retrieve the relevant context (chunks) from the knowledge base.
    ai:QueryMatch[] queryMatches = check knowledgeBase.retrieve(appealQuery, 10);
    ai:Chunk[] context = from ai:QueryMatch queryMatch in queryMatches
                            select queryMatch.chunk;

    // Use the `generate` method, inserting the context and query to the prompt.
    string answer = check modelProvider->generate(`Answer the query based on the 
	    following context:

        Context: ${context}

        Query: ${appealQuery}

        Base the answer only on the above context. If the answer is not
        contained within the context, respond with "I don't know".`);
    io:println("Query: ", appealQuery);
    io:println("Answer: ", answer);

    string carryForwardQuery = 
        "How many annual leave days can a full-time employee carry forward to the next year?";
    
    queryMatches = check knowledgeBase.retrieve(carryForwardQuery, 10);
    context = from ai:QueryMatch queryMatch in queryMatches
                            select queryMatch.chunk;

    // The `augmentUserQuery` function augments the user query with the context using 
    // a generic prompt template.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, carryForwardQuery);

    // Use the `chat` method with the `ai:ChatUserMessage` with the augmented query.
    ai:ChatAssistantMessage assistantMessage = check modelProvider->chat(augmentedQuery);
    
    io:println("\nQuery: ", carryForwardQuery);
    io:println("Answer: ", assistantMessage.content);
}
