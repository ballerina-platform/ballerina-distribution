import ballerina/ai;
import ballerina/io;
import ballerinax/ai.wso2.integration as wso2;

// Configuration for the WSO2 Integration knowledge base.
configurable string knowledgeBaseUrl = ?;
configurable string knowledgeBaseToken = ?;

// The knowledge base is hosted and populated on the WSO2 Integration Platform, so the
// application only retrieves from it. The `ingest` and `deleteByFilter` methods are not
// supported yet.
final ai:KnowledgeBase knowledgeBase = check new wso2:CloudKnowledgeBase(knowledgeBaseUrl,
        {auth: {token: knowledgeBaseToken}},
        // Chunks scoring below this similarity threshold are dropped.
        minSimilarityThreshold = 0.7);

# Searches the company knowledge base for information relevant to a question.
# + query - The question to search the knowledge base for
# + return - The matching excerpts from the knowledge base
@ai:AgentTool
isolated function searchKnowledgeBase(string query) returns string[]|ai:Error {
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    return from ai:QueryMatch queryMatch in matches
        select queryMatch.chunk.content.toString();
}

// Retrieval is a tool rather than a fixed step, so the agent decides whether to search,
// what to search for, and can search several times before it answers.
final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Support Assistant",
        instructions: string `Answer questions using the company knowledge base. Search the
            knowledge base before answering, and base the answer only on what the search
            returns. Keep answers brief.`
    },
    model: check ai:getDefaultModelProvider(),
    tools: [searchKnowledgeBase]
});

public function main() returns error? {
    string response = check supportAgent.run("How do I configure a scheduled task?");
    io:println(response);
}
