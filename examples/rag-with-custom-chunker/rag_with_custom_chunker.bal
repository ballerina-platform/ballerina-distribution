import ballerina/ai;
import ballerina/io;

// A custom chunker that implements the `ai:Chunker` type. The built-in chunkers split by
// structure or size; this chunker understands the FAQ format of the document and produces
// one chunk per question-and-answer pair, so that a retrieved chunk is always a complete FAQ
// entry. The question is kept as metadata for filtering and display.
isolated class FaqChunker {
    *ai:Chunker;

    public isolated function chunk(ai:Document document) returns ai:Chunk[]|ai:Error {
        if document !is ai:TextDocument {
            return error ai:Error("Only text documents are supported");
        }
        ai:TextChunk[] chunks = [];
        // Each FAQ entry starts with "Q:" on a new line.
        foreach string entry in re `\nQ:`.split("\n" + document.content.trim()) {
            string trimmedEntry = entry.trim();
            if trimmedEntry == "" {
                continue;
            }
            string[] parts = re `\nA:`.split(trimmedEntry);
            ai:Metadata metadata = document.metadata.clone() ?: {};
            metadata["question"] = parts[0].trim();
            metadata.index = chunks.length();
            chunks.push({content: "Q: " + trimmedEntry, metadata});
        }
        return chunks;
    }
}

public function main() returns error? {
    ai:TextDocument faq = {
        metadata: {fileName: "hr_faq.txt"},
        content: string `Q: How many days of annual leave do I get?
A: Full-time employees get 20 days of paid annual leave per year.
Q: Do I need a medical certificate for sick leave?
A: Only for absences longer than two consecutive days.
Q: How do I submit an expense report?
A: Submit it through the finance portal within 30 days of the expense.`
    };

    // Use the custom chunker like any built-in chunker.
    ai:Chunker chunker = new FaqChunker();
    ai:Chunk[] chunks = check chunker.chunk(faq);
    io:println("Chunks produced: ", chunks.length());
    foreach ai:Chunk chunk in chunks {
        io:println("[", chunk.metadata?.index, "] question: ", chunk.metadata["question"]);
        io:println("    ", chunk.content);
    }

    // A custom chunker can also be passed to a knowledge base, so that the documents are
    // chunked with it during ingestion:
    // `new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, new FaqChunker())`.
}
