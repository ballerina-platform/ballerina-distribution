import ballerina/ai;
import ballerina/io;
import ballerinax/ai.pgvector;

// Configuration for the PostgreSQL database with the pgvector extension.
configurable string pgHost = "localhost";
configurable int pgPort = 5432;
configurable string pgUser = "postgres";
configurable string pgPassword = ?;
configurable string pgDatabase = "vector_db";

// Connect to the table that the ingestion example populated.
final ai:VectorStore vectorStore = check new pgvector:VectorStore(pgHost, pgUser, pgPassword,
        pgDatabase, tableName = "leave_policy_vectors", port = pgPort,
        configs = {vectorDimension: 1536});

// Retrieval must use the embedding provider that was used for ingestion, so that the
// query and the stored chunks are embedded into the same vector space.
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

// Use the default model provider to generate the final response.
final ai:ModelProvider model = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Retrieve the chunks that are most similar to the query using vector similarity search.
    string query = "How much paid vacation do I get?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the user query with the retrieved context and generate the response.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response?.content);
}
