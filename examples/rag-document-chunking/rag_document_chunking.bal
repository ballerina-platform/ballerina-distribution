import ballerina/ai;
import ballerina/io;

// The documents of each type are kept in a separate array, so that each type can be chunked
// with the chunking function for that type.
final ai:TextDocument[] markdownDocuments = [
    {
        content: "# Leave policy\n\n## Annual leave\n\n20 days of paid leave per year.\n\n" +
            "## Sick leave\n\n10 days of paid sick leave per year.",
        metadata: {fileName: "leave_policy.md"}
    }
];

final ai:TextDocument[] htmlDocuments = [
    {
        content: "<h1>Travel policy</h1><h2>Booking</h2><p>Book travel two weeks in advance.</p>" +
            "<h2>Meals</h2><p>Meals are reimbursed up to 60 USD per day.</p>",
        metadata: {fileName: "travel_policy.html"}
    }
];

final ai:TextDocument[] textDocuments = [
    {
        content: "Treat colleagues with respect. Harassment is not tolerated. Report concerns to HR.",
        metadata: {fileName: "code_of_conduct.txt"}
    }
];

public function main() returns error? {
    // Chunk each document type with the chunking function for that type. Each function
    // splits by the structure of the document (e.g., headers) and recursively falls back
    // to smaller units (e.g., sentences) when a chunk exceeds `maxChunkSize` characters.
    ai:Chunk[] markdownChunks = check ai:chunkMarkdownDocument(markdownDocuments[0],
            maxChunkSize = 70, maxOverlapSize = 0);
    printChunks("Markdown chunks", markdownChunks);

    ai:Chunk[] htmlChunks = check ai:chunkHtmlDocument(htmlDocuments[0],
            maxChunkSize = 80, maxOverlapSize = 0);
    printChunks("HTML chunks", htmlChunks);

    ai:Chunk[] textChunks = check ai:chunkDocumentRecursively(textDocuments[0],
            maxChunkSize = 40, maxOverlapSize = 0, strategy = ai:SENTENCE);
    printChunks("Text chunks", textChunks);

    // A knowledge base created with `ai:AUTO` (the default) detects the chunker for each
    // document from its `mimeType` metadata or file extension: `.md` documents use the
    // Markdown chunker, `.html` documents use the HTML chunker, and other documents use
    // the generic recursive chunker. So, all the arrays can be ingested together.
    ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();
    ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore,
            check ai:getDefaultEmbeddingProvider(), ai:AUTO);
    check knowledgeBase.ingest([...markdownDocuments, ...htmlDocuments, ...textDocuments]);

    // Inspect the chunks that were stored. A query without an embedding or filters returns
    // all the entries (`topK` of `-1` removes the limit).
    ai:VectorMatch[] entries = check vectorStore.query({topK: -1});
    printChunks("Chunks stored with ai:AUTO", from ai:VectorMatch entry in entries
        select entry.chunk);
}

function printChunks(string title, ai:Chunk[] chunks) {
    io:println(title, ": ", chunks.length());
    foreach ai:Chunk chunk in chunks {
        io:println("- [", chunk.metadata?.fileName ?: "-", "] ",
                re `\s+`.replaceAll(chunk.content.toString(), " ").trim());
    }
}
