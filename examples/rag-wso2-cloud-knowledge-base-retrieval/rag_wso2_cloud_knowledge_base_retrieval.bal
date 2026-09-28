import ballerina/ai;
import ballerina/io;
import ballerinax/ai.wso2.integration as wso2;

// Configuration for the WSO2 Cloud knowledge base. Add the values to the `Config.toml` file.
configurable string knowledgeBaseUrl = ?;
configurable string knowledgeBaseToken = ?;
// Optional configuration for reranking the retrieved chunks with Cohere.
configurable string? cohereRerankerApiKey = ();
configurable string? cohereRerankerModel = ();

// The knowledge base is hosted on the WSO2 Integration Platform, where the documents are
// ingested, chunked, and embedded. The application only retrieves from it, so no embedding
// provider is configured here. The `ingest` and `deleteByFilter` methods are not supported yet.
final ai:KnowledgeBase knowledgeBase = check new wso2:CloudKnowledgeBase(knowledgeBaseUrl,
        // Authenticate with a bearer token, or with OAuth2 client credentials.
        {auth: {token: knowledgeBaseToken}},
        // Chunks scoring below this similarity threshold are dropped. The default is 0.7.
        minSimilarityThreshold = 0.75,
        // Rerank the retrieved chunks with Cohere. Reranking is disabled when no API key is set.
        cohereRerankerApiKey = cohereRerankerApiKey,
        cohereRerankerModel = cohereRerankerModel,
        // The number of top chunks to keep after reranking. The default is 5.
        rerankerTopN = 3,
        // Additional HTTP connection configurations, such as the timeout and retries.
        timeout = 30,
        retryConfig = {count: 3, interval: 2});

// Use the default model provider (with configuration added via a Ballerina VS Code command)
// to generate the final response.
final ai:ModelProvider model = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Retrieve the chunks that are most relevant to the query. The platform embeds the query
    // and searches the knowledge base; the results carry their similarity scores.
    string query = "How do I configure a scheduled task?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    io:println("Retrieved chunks: ", matches.length());
    foreach ai:QueryMatch queryMatch in matches {
        io:println("- ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the user query with the retrieved context and generate the response.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response.content);
}
