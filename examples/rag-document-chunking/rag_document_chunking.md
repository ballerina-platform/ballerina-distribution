# Chunk documents

Before you embed documents for retrieval-augmented generation (RAG), you split them into chunks. The `ballerina/ai` module has a chunking function for each document type: `ai:chunkMarkdownDocument`, `ai:chunkHtmlDocument`, and `ai:chunkDocumentRecursively` for generic text. Each one splits by the document structure and falls back to smaller units when a chunk exceeds `maxChunkSize` characters. An `ai:VectorKnowledgeBase` created with `ai:AUTO` (the default) picks the chunker for each document from its `mimeType` metadata or file extension.

This example chunks Markdown, HTML, and text documents, and then ingests them all into a knowledge base that uses `ai:AUTO`.

> Note: This example uses the default embedding provider implementation for the knowledge base. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_document_chunking.bal :::

::: out rag_document_chunking.out :::

## Related links

- [The Ingest with a configured chunker example](/learn/by-example/rag-with-configured-chunker/)
- [The Implement a custom chunker example](/learn/by-example/rag-with-custom-chunker/)
- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The Filter results by metadata example](/learn/by-example/rag-query-with-metadata-filters/)
