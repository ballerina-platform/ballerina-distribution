import ballerina/ai;
import ballerina/io;

// Use the default embedding provider implementation
// (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create a knowledge base with the in-memory vector store.
// Metadata filtering is also supported by the external vector store implementations.
// The chunker argument is optional and defaults to `ai:AUTO`, which selects a chunker based
// on the type of each ingested document or chunk. Pass a specific `ai:Chunker` for finer
// control, or `ai:DISABLE` to store each input as a single chunk.
final ai:KnowledgeBase knowledgeBase =
        new ai:VectorKnowledgeBase(check new ai:InMemoryVectorStore(), embeddingProvider, ai:AUTO);

public function main() returns error? {
    // Ingest chunks with custom metadata. In addition to the predefined fields
    // (e.g., `fileName`, `index`), `ai:Metadata` allows arbitrary fields.
    ai:TextChunk[] chunks = [
        {content: "Employees get 20 days of paid annual leave.",
            metadata: {"department": "HR", "year": 2025}},
        {content: "Employees get 18 days of paid annual leave.",
            metadata: {"department": "HR", "year": 2023}},
        {content: "Production deployments require two approvals.",
            metadata: {"department": "Engineering", "year": 2025}},
        {content: "Expense reports must be submitted within 30 days.",
            metadata: {"department": "Finance", "year": 2025}}
    ];
    check knowledgeBase.ingest(chunks);

    string query = "How many days of leave do employees get?";

    // Retrieve without filters: results are ranked by vector similarity only.
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 4);
    io:println("Without filters:");
    printMatches(matches);

    // Retrieve with a metadata filter to restrict the search to a specific department.
    // The default operator is `ai:EQUAL`.
    matches = check knowledgeBase.retrieve(query, 4, {
        filters: [{key: "department", value: "HR"}]
    });
    io:println("\nFiltered by department == HR:");
    printMatches(matches);

    // Combine multiple filters with `ai:AND`/`ai:OR` conditions and use comparison
    // operators such as `ai:GREATER_THAN_OR_EQUAL` or `ai:IN`.
    matches = check knowledgeBase.retrieve(query, 4, {
        condition: ai:AND,
        filters: [
            {key: "department", operator: ai:IN, value: ["HR", "Finance"]},
            {key: "year", operator: ai:GREATER_THAN_OR_EQUAL, value: 2025}
        ]
    });
    io:println("\nFiltered by department in [HR, Finance] and year >= 2025:");
    printMatches(matches);

    // Metadata filters can also be used to delete chunks from the knowledge base.
    check knowledgeBase.deleteByFilter({filters: [{key: "year", operator: ai:LESS_THAN, value: 2025}]});
    matches = check knowledgeBase.retrieve(query, 4, {filters: [{key: "department", value: "HR"}]});
    io:println("\nHR chunks after deleting chunks from before 2025:");
    printMatches(matches);
}

function printMatches(ai:QueryMatch[] matches) {
    foreach ai:QueryMatch queryMatch in matches {
        io:println("- ", queryMatch.chunk.content, " ", queryMatch.chunk.metadata.toString());
    }
}
