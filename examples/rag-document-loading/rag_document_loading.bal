import ballerina/ai;
import ballerina/io;

public function main() returns error? {
    // A data loader (`ai:DataLoader`) loads documents from a source as `ai:Document` values,
    // which is the first step of a retrieval-augmented generation (RAG) ingestion workflow.
    // `ai:TextDataLoader` loads files as `ai:TextDocument`s and supports the
    // `pdf`, `docx`, `markdown`, `html`, and `pptx` file types.
    ai:DataLoader loader = check new ai:TextDataLoader("./employee_handbook.md", "./leave_policy.pdf");

    // The `load` method returns a single document or an array of documents.
    ai:Document|ai:Document[] loaded = check loader.load();
    ai:Document[] documents = loaded is ai:Document[] ? loaded : [loaded];

    foreach ai:Document document in documents {
        // The document type is "text" for text documents. The metadata includes
        // details such as the file name.
        io:println("Type: ", document.'type);
        io:println("File name: ", document.metadata?.fileName);

        if document is ai:TextDocument {
            // The extracted text content is available as a string.
            string content = document.content.trim();
            int previewLength = content.length() < 80 ? content.length() : 80;
            io:println("Content preview: ", content.substring(0, previewLength), "...");
        }
        io:println();
    }

    // The loaded documents can be ingested into a knowledge base (`ai:KnowledgeBase`),
    // which handles chunking and embedding, as demonstrated in the RAG ingestion example.
}
