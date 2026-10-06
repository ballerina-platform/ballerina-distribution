import ballerina/ai;
import ballerina/io;
import ballerinax/ai.googleapis.vertex;

// Google Cloud configuration. Add the values to the `Config.toml` file.
configurable string serviceAccountKeyPath = ?;
configurable string projectId = ?;
configurable string location = "us-central1";

// Define the embedding provider and the model provider for Google Vertex AI.
final ai:EmbeddingProvider embeddingProvider =
        check new vertex:EmbeddingProvider(serviceAccountKeyPath, projectId, location);
final ai:ModelProvider model =
        check new vertex:ModelProvider(serviceAccountKeyPath, projectId, "google/gemini-2.5-flash", location);

// Create the knowledge base with the in-memory vector store and the embedding provider.
final ai:KnowledgeBase knowledgeBase =
        new ai:VectorKnowledgeBase(check new ai:InMemoryVectorStore(), embeddingProvider);

public function main() returns error? {
    // An in-memory vector store is emptied when the program stops, so the documents are
    // ingested in the same program before they are retrieved. With an external vector store,
    // the ingestion example can be run separately.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check knowledgeBase.ingest(documents);

    // Retrieve the most relevant chunks for the query. The query is embedded with the
    // same Vertex AI embedding model that was used for ingestion.
    string query = "How much paid vacation do I get?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the user query with the retrieved context and generate the response with Gemini.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response?.content);
}
