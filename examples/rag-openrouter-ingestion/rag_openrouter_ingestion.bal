import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openrouter;

// The API key for OpenRouter. Add it to the `Config.toml` file.
configurable string openRouterApiKey = ?;

// OpenRouter provides unified access to models from many providers through a single API.
// Define the embedding provider using an OpenRouter model identifier.
final ai:EmbeddingProvider embeddingProvider =
        check new openrouter:EmbeddingProvider(openRouterApiKey, "openai/text-embedding-3-small");

// Define the vector store. The example uses the in-memory vector store; any `ai:VectorStore`
// implementation (e.g., pgvector, Pinecone) can be used instead to persist the vectors.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Create the knowledge base with the vector store and the OpenRouter embedding provider.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

public function main() returns error? {
    // Ingest the documents. Each chunk is embedded through OpenRouter and stored in the vector store.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");
}
