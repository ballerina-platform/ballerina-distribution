import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// Azure AI Search and Azure OpenAI configuration. Add the values to the `Config.toml` file.
configurable string searchServiceUrl = ?;
configurable string searchApiKey = ?;
configurable string openAiServiceUrl = ?;
configurable string openAiApiKey = ?;
configurable string chatDeploymentId = ?;
configurable string embeddingDeploymentId = ?;

// Retrieval must use the embedding provider that was used for ingestion, so that the
// query and the stored chunks are embedded into the same vector space.
final ai:EmbeddingProvider embeddingProvider =
        check new azure:EmbeddingProvider(openAiServiceUrl, openAiApiKey, (), embeddingDeploymentId);

// Use Azure OpenAI to generate the final response.
final ai:ModelProvider model = check new azure:OpenAiModelProvider(openAiServiceUrl, openAiApiKey, chatDeploymentId);

public function main() returns error? {
    // Create a knowledge base backed by an existing index by passing the index name.
    // The index must already exist in the Azure AI Search service.
    ai:KnowledgeBase knowledgeBase = check new azure:AiSearchKnowledgeBase(searchServiceUrl, searchApiKey,
            "hr-policies", embeddingProvider);

    // Retrieve the most relevant chunks for the query using vector search.
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
