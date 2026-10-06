import ballerina/ai;
import ballerina/io;
import ballerinax/ai.googleapis.vertex;

// Google Cloud configuration. Add the values to the `Config.toml` file.
configurable string serviceAccountKeyPath = ?;
configurable string projectId = ?;
configurable string location = "us-central1";

// Define the embedding provider for Google Vertex AI. The provider authenticates with a
// service account key file (OAuth2 refresh tokens and service account credentials are also
// supported).
final ai:EmbeddingProvider embeddingProvider =
        check new vertex:EmbeddingProvider(serviceAccountKeyPath, projectId, location);

// Define the vector store. The example uses the in-memory vector store; any `ai:VectorStore`
// implementation (e.g., pgvector, Pinecone) can be used instead to persist the vectors.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Create the knowledge base with the vector store and the Vertex AI embedding provider.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

public function main() returns error? {
    // Ingest the documents. Each chunk is embedded with the Vertex AI embedding model
    // and stored in the vector store.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");
}
