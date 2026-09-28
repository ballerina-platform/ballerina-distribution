import ballerina/ai;
import ballerina/io;

// Use the default embedding provider (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create the knowledge base with chunking disabled (`ai:DISABLE`). Each ingested document is
// embedded and stored as a single chunk, without being split. This is useful when the documents
// are already small and self-contained (e.g., FAQ entries, product descriptions, or tickets),
// or when they have been chunked beforehand.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, ai:DISABLE);

public function main() returns error? {
    // Each FAQ entry is a small, self-contained document.
    ai:TextDocument[] faqs = [
        {content: "Q: How many days of annual leave do I get? A: Full-time employees get 20 days per year."},
        {content: "Q: Do I need a medical certificate for sick leave? A: Only for absences longer than two days."},
        {content: "Q: How do I submit an expense report? A: Submit it through the finance portal within 30 days."}
    ];

    // The documents are stored as they are, one chunk per document.
    check knowledgeBase.ingest(faqs);
    io:println("Ingestion successful");
}
