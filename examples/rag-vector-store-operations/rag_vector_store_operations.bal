import ballerina/ai;
import ballerina/io;

// Use the default embedding provider (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// A vector store (`ai:VectorStore`) persists vector entries and searches them by similarity.
// The knowledge base uses a vector store under the hood; this example uses the store directly
// to show the underlying operations. The same operations are available on the external
// implementations (e.g., pgvector, Pinecone).
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

public function main() returns error? {
    // Create the entries to store. Each entry pairs a chunk with its embedding, and can
    // have an ID and metadata.
    ai:TextChunk[] chunks = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year.",
            metadata: {"topic": "leave"}},
        {content: "Employees are entitled to 10 days of paid sick leave per year.",
            metadata: {"topic": "leave"}},
        {content: "Expense reports must be submitted within 30 days of travel.",
            metadata: {"topic": "expenses"}}
    ];
    ai:Embedding[] embeddings = check embeddingProvider->batchEmbed(chunks);
    ai:VectorEntry[] entries = from int i in 0 ..< chunks.length()
        select {id: string `chunk-${i + 1}`, embedding: embeddings[i], chunk: chunks[i]};

    // Add the entries to the store.
    check vectorStore.add(entries);
    io:println("Entries added: ", entries.length());

    // Query the store with the embedding of a question. The results are ranked by similarity.
    ai:Embedding queryEmbedding = check embeddingProvider->embed(<ai:TextChunk>{content: "How many vacation days do I get?"});
    ai:VectorMatch[] matches = check vectorStore.query({embedding: queryEmbedding, topK: 2});
    io:println("\nTop matches:");
    foreach ai:VectorMatch vectorMatch in matches {
        io:println("- ", vectorMatch.chunk.content, " (score: ", vectorMatch.similarityScore, ")");
    }

    // Combine similarity search with metadata filters.
    matches = check vectorStore.query({embedding: queryEmbedding, topK: 2,
        filters: {filters: [{key: "topic", value: "expenses"}]}});
    io:println("\nTop matches with topic == expenses:");
    foreach ai:VectorMatch vectorMatch in matches {
        io:println("- ", vectorMatch.chunk.content, " (score: ", vectorMatch.similarityScore, ")");
    }

    // Delete entries by ID. A query without an embedding or filters returns all the
    // remaining entries (`topK` of `-1` removes the limit).
    check vectorStore.delete(["chunk-3"]);
    ai:VectorMatch[] remaining = check vectorStore.query({topK: -1});
    io:println("\nEntries after deleting chunk-3: ", remaining.length());
}
