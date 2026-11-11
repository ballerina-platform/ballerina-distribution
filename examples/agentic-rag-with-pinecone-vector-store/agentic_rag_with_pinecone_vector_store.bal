import ballerina/ai;
import ballerina/io;
import ballerinax/ai.pinecone;

// Configuration for Pinecone.
configurable string pineconeServiceUrl = ?;
configurable string pineconeApiKey = ?;

// Connect to the Pinecone index that the RAG ingestion example populated.
final ai:VectorStore vectorStore = check new pinecone:VectorStore(pineconeServiceUrl, pineconeApiKey);

// Retrieval must use the embedding provider that was used for ingestion, so that the query
// and the stored chunks are embedded into the same vector space.
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

# Searches the company leave policy for information relevant to a question.
# + query - The question to search the leave policy for
# + return - The matching excerpts of the leave policy
@ai:AgentTool
isolated function searchLeavePolicy(string query) returns string[]|ai:Error {
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    return from ai:QueryMatch queryMatch in matches
        select queryMatch.chunk.content.toString();
}

// In agentic RAG, retrieval is a tool instead of a fixed step before the LLM call. The agent
// decides whether to search, what to search for, and can search several times with refined
// queries before it answers.
final ai:Agent hrAgent = check new ({
    systemPrompt: {
        role: "HR Assistant",
        instructions: string `Answer questions about the company leave policy. Search the
            policy before answering, and base the answer only on what the search returns.
            For a question with several parts, search for each part separately.
            Keep answers brief.`
    },
    model: check ai:getDefaultModelProvider(),
    tools: [searchLeavePolicy]
});

public function main() returns error? {
    // The agent searches the knowledge base once and answers from the result.
    string response = check hrAgent.run("How many annual leave days does a full-time employee get?");
    io:println(response);

    // Answering this needs information from two different parts of the policy, so the agent
    // searches more than once before answering.
    response = check hrAgent.run(string `What notice is required for parental leave, and how do
            I appeal a rejected leave request?`);
    io:println("\n", response);
}
