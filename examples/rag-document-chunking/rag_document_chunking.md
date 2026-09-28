# Chunk documents

Documents are split into smaller chunks before they are embedded and indexed for retrieval-augmented generation (RAG). The `ballerina/ai` module provides a chunking function for each document type: `ai:chunkMarkdownDocument` for Markdown, `ai:chunkHtmlDocument` for HTML, and `ai:chunkDocumentRecursively` for generic text. Each function uses the structure of the document type, such as headers, to produce meaningful chunks and recursively falls back to smaller units, such as sentences, when a chunk exceeds `maxChunkSize` characters. The same chunkers are available as the `ai:MarkdownChunker`, `ai:HtmlChunker`, and `ai:GenericRecursiveChunker` classes.

You rarely need to choose the chunker yourself. An `ai:VectorKnowledgeBase` created with `ai:AUTO` (the default) detects the chunker for each document when it is ingested. It uses the `mimeType` metadata of the document (`text/markdown` or `text/html`), falls back to the file extension (`.md` or `.html`) in the `fileName` metadata, and uses the generic recursive chunker for any other document. The automatically selected chunkers use the default maximum chunk size of 200 characters, so each of the short documents in this example is stored as a single chunk.

This example demonstrates chunking Markdown, HTML, and text documents with the chunking function for each type, and then ingesting all of them into a knowledge base that selects the chunkers with `ai:AUTO`.

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
