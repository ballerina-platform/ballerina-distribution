# Ingest with a configured chunker

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Its `ingest` method splits the documents into chunks, embeds the chunks with an embedding provider, and stores them in a vector store. By default (`ai:AUTO`), the knowledge base selects a chunker based on the type of each document. To control the chunk size, the overlap, or the splitting strategy, pass a configured `ai:Chunker`, such as `ai:GenericRecursiveChunker`, `ai:MarkdownChunker`, or `ai:HtmlChunker`.

This example ingests a document into an in-memory vector store with an `ai:GenericRecursiveChunker` that splits by sentence into chunks of up to 120 characters.

For the query part, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_configured_chunker.bal :::

::: out rag_with_configured_chunker.out :::

## Related links

- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Implement a custom chunker example](/learn/by-example/rag-with-custom-chunker/)
- [The Ingest without chunking example](/learn/by-example/rag-without-chunking/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
