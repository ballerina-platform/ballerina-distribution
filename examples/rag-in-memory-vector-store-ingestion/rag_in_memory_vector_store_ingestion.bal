import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store. It keeps the vectors in the memory of the running program,
// which makes it suitable for development, tests, and small datasets.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Define the embedding provider to use.
// The example uses the default embedding provider implementation
// (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create the knowledge base with the vector store and embedding provider.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

public function main() returns error? {
    // Use a data loader to load the documents.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest the documents into the knowledge base. The knowledge base chunks the
    // documents, embeds the chunks, and stores the vectors in the vector store.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");
}
