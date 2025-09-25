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

public function main() returns error? {
    // Use data loaders to load documents.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.pdf");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest the documents into the knowledge base. 
    // When `ai:Document`s are ingested, chunking is handled by the knowledge base.
    // Alternatively, for finer control, you can use the required chunker
    // (`ai:Chunker` implementations) to chunk documents and pass the chunks
    // as the argument.
    ai:Error? ingestionResult = knowledgeBase.ingest(documents);
    if ingestionResult is () {
        io:println("Ingestion successful");
    } else {
        io:println("Ingestion failed: ", ingestionResult.message());
    }
}
