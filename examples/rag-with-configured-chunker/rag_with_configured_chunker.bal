import ballerina/ai;
import ballerina/io;

// Use the default embedding provider (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Define the chunker to use when documents are ingested. Instead of the default `ai:AUTO`
// configuration, which selects a chunker based on the document type, this example uses a
// generic recursive chunker that splits by sentences into chunks of at most 120 characters.
// Consecutive chunks can share up to 20 characters of overlap, made of whole sentences, to
// preserve context.
final ai:Chunker chunker = new ai:GenericRecursiveChunker(maxChunkSize = 120, maxOverlapSize = 20,
        strategy = ai:SENTENCE);

// Define the vector store. The example uses the in-memory vector store; any `ai:VectorStore`
// implementation can be used instead.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Create the knowledge base with the vector store, the embedding provider,
// and the configured chunker. Any `ai:Chunker` implementation, including your own, can be used.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, chunker);

public function main() returns error? {
    ai:TextDocument policy = {
        metadata: {fileName: "leave_policy.txt"},
        content: string `Full-time employees are entitled to 20 days of paid annual leave per year.
Leave requests must be submitted at least one week in advance.
Employees are entitled to 10 days of paid sick leave per year.
A medical certificate is required for absences longer than two consecutive days.
Parental leave is 12 weeks and must be requested one month in advance.`
    };

    // The document is split by the configured chunker before the chunks are embedded and stored.
    check knowledgeBase.ingest(policy);
    io:println("Ingestion successful");
}
