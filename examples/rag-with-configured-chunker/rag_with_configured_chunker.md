# Ingest with a configured chunker

By default, an `ai:VectorKnowledgeBase` chunks ingested documents with the `ai:AUTO` configuration, which selects a chunker based on the type of each document. When you need control over the chunk size, overlap, or splitting strategy, pass a configured `ai:Chunker` when creating the knowledge base instead. Ballerina provides `ai:GenericRecursiveChunker`, `ai:MarkdownChunker`, and `ai:HtmlChunker`, and you can also implement the `ai:Chunker` type yourself.

This example demonstrates a knowledge base that uses a generic recursive chunker with a sentence-based strategy and a small chunk size, so that each sentence is stored as a separate chunk. It covers ingestion only. To retrieve from a knowledge base, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_configured_chunker.bal :::

::: out rag_with_configured_chunker.out :::

## Related links

- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Implement a custom chunker example](/learn/by-example/rag-with-custom-chunker/)
- [The Ingest without chunking example](/learn/by-example/rag-without-chunking/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
