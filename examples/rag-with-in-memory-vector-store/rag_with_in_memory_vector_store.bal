import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

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
    // Ingestion process.
    // Use data loaders to load documents.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest the documents into the knowledge base. 
    // When `ai:Document`s are ingested, chunking is handled by the knowledge base.
    // Alternatively, for finer control, you can use the required chunker
    // (`ai:Chunker` implementations) to chunk documents and pass the chunks
    // as the argument.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");

    // Querying process.
    string query = 
        "How many annual leave days can a full-time employee carry forward to the next year?";

    ai:QueryMatch[] queryMatches = check knowledgeBase.retrieve(query, 10);
    ai:Chunk[] context = from ai:QueryMatch queryMatch in queryMatches
                            select queryMatch.chunk;

    // The `augmentUserQuery` function augments the user query with the context using 
    // a generic prompt template.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);

    // Use the `chat` method with the `ai:ChatUserMessage` with the augmented query.
    ai:ChatAssistantMessage assistantMessage = check modelProvider->chat(augmentedQuery);
    
    io:println("\nQuery: ", query);
    io:println("Answer: ", assistantMessage.content);
}
