import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;

// The API key for the embedding provider. Add it to the `Config.toml` file.
configurable string openAiApiKey = ?;

// Initialize an embedding provider for a specific provider using your own API key.
// This example uses OpenAI; other `ballerinax/ai.<provider>` modules follow the same pattern.
final ai:EmbeddingProvider embeddingProvider =
        check new openai:EmbeddingProvider(openAiApiKey, openai:TEXT_EMBEDDING_3_SMALL);

public function main() returns error? {
    // An embedding provider converts a chunk into a vector embedding. Semantically
    // similar text produces vectors that are close to each other.
    ai:TextChunk document = {content: "Employees are entitled to 20 days of paid annual leave per year."};
    ai:Embedding documentEmbedding = check embeddingProvider->embed(document);

    // Use `batchEmbed` to embed multiple chunks in a single request.
    ai:TextChunk[] candidates = [
        {content: "How many days of vacation do I get?"},
        {content: "Sick leave requires a medical certificate after two days."},
        {content: "The quarterly sales report is due on Friday."}
    ];
    ai:Embedding[] candidateEmbeddings = check embeddingProvider->batchEmbed(candidates);

    // Compare each candidate with the document using cosine similarity.
    // The provider used in this example returns dense vectors (`ai:Vector`).
    foreach int i in 0 ..< candidates.length() {
        ai:Embedding candidateEmbedding = candidateEmbeddings[i];
        if documentEmbedding is ai:Vector && candidateEmbedding is ai:Vector {
            float similarity = cosineSimilarity(documentEmbedding, candidateEmbedding);
            io:println(string `Similarity with "${candidates[i].content}": ${similarity}`);
        }
    }
}

function cosineSimilarity(ai:Vector a, ai:Vector b) returns float {
    float dot = 0.0;
    float normA = 0.0;
    float normB = 0.0;
    foreach int i in 0 ..< a.length() {
        dot += a[i] * b[i];
        normA += a[i] * a[i];
        normB += b[i] * b[i];
    }
    return dot / (normA.sqrt() * normB.sqrt());
}
