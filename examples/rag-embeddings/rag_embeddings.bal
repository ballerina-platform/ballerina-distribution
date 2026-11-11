import ballerina/ai;
import ballerina/io;

// Use the default embedding provider (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

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
    // The default provider returns dense vectors (`ai:Vector`).
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
