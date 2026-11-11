import ballerina/ai;
import ballerina/http;
import ballerina/io;

// The embeddings service to use. The example uses a local Ollama server, which exposes an
// OpenAI-compatible embeddings API, with the `nomic-embed-text` model.
configurable string embeddingServiceUrl = "http://localhost:11434/v1";
configurable string embeddingModel = "nomic-embed-text";

# The response of an OpenAI-compatible embeddings API.
type EmbeddingResponse record {
    # The embeddings, one for each input
    record {
        # The position of the input that the embedding belongs to
        int index;
        # The embedding vector
        float[] embedding;
    }[] data;
};

// A custom embedding provider that implements the `ai:EmbeddingProvider` type. It calls
// the `/embeddings` endpoint of any service that follows the OpenAI embeddings API, such as
// Ollama, vLLM, or an internal embeddings gateway.
isolated client class OpenAiCompatibleEmbeddingProvider {
    *ai:EmbeddingProvider;

    private final http:Client embeddingClient;
    private final string model;

    isolated function init(string serviceUrl, string model) returns ai:Error? {
        http:Client|error embeddingClient = new (serviceUrl);
        if embeddingClient is error {
            return error ai:Error("Failed to initialize the embeddings client", embeddingClient);
        }
        self.embeddingClient = embeddingClient;
        self.model = model;
    }

    // Converts a single chunk into an embedding.
    isolated remote function embed(ai:Chunk chunk) returns ai:Embedding|ai:Error {
        ai:Embedding[] embeddings = check self->batchEmbed([chunk]);
        return embeddings[0];
    }

    // Converts a batch of chunks into embeddings with a single request.
    isolated remote function batchEmbed(ai:Chunk[] chunks) returns ai:Embedding[]|ai:Error {
        string[] input = [];
        foreach ai:Chunk chunk in chunks {
            anydata content = chunk.content;
            if content !is string {
                return error ai:Error("Only text chunks are supported");
            }
            input.push(content);
        }
        EmbeddingResponse|error response = self.embeddingClient->/embeddings.post({model: self.model, input});
        if response is error {
            return error ai:Error("Failed to generate embeddings: " + response.message(), response);
        }
        // Return the embeddings in the order of the inputs.
        return from var item in response.data
            order by item.index
            select item.embedding;
    }
}

public function main() returns error? {
    ai:EmbeddingProvider embeddingProvider =
        check new OpenAiCompatibleEmbeddingProvider(embeddingServiceUrl, embeddingModel);

    // Use the custom provider directly.
    ai:Embedding embedding = check embeddingProvider->embed(<ai:TextChunk>{content: "Hello, Ballerina!"});
    if embedding is ai:Vector {
        io:println("Embedding dimensions: ", embedding.length());
    }

    // Or pass it to a knowledge base, like any other embedding provider. The knowledge base
    // uses it to embed the chunks when ingesting, and the query when retrieving.
    ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();
    ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);
    check knowledgeBase.ingest([
        <ai:TextDocument>{content: "Full-time employees get 20 days of paid annual leave per year."},
        <ai:TextDocument>{content: "Expense claims must be submitted within 30 days."},
        <ai:TextDocument>{content: "The office is closed on public holidays."}
    ]);

    ai:QueryMatch[] matches = check knowledgeBase.retrieve("How much vacation do I get?", 1);
    io:println("Best match: ", matches[0].chunk.content);
}
