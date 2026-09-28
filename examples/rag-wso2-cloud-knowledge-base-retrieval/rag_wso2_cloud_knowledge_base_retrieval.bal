import ballerina/ai;
import ballerina/io;
import ballerinax/ai.wso2.integration as wso2;

// Configuration for the WSO2 Cloud knowledge base. Add the values to the `Config.toml` file.
configurable string knowledgeBaseUrl = ?;
configurable string knowledgeBaseToken = ?;

// The knowledge base is hosted on the WSO2 Integration platform, where the documents are
// ingested, chunked, and embedded. The application only retrieves from it, so no embedding
// provider is configured here; the `ingest` and `deleteByFilter` methods return an error.
final ai:KnowledgeBase knowledgeBase = check new wso2:CloudKnowledgeBase(knowledgeBaseUrl,
        {auth: {token: knowledgeBaseToken}},
        // Chunks scoring below this similarity threshold are dropped. The default is 0.7.
        minSimilarityThreshold = 0.75);

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
