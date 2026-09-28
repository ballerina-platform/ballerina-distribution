# Ingest without chunking

Chunking is not always desirable. When the documents to be indexed are already small and self-contained, such as FAQ entries, product descriptions, or support tickets, or when they have been chunked beforehand, splitting them further can break their meaning. Passing `ai:DISABLE` as the chunker when creating an `ai:VectorKnowledgeBase` stores each ingested document as a single chunk.

This example demonstrates a knowledge base with chunking disabled, where each FAQ entry is embedded and stored as a whole. It covers ingestion only. To retrieve from a knowledge base, see the [Retrieve from an in-memory vector store](/learn/by-example/rag-in-memory-vector-store-retrieval/) example.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_without_chunking.bal :::

::: out rag_without_chunking.out :::

## Related links

- [The Implement a custom chunker example](/learn/by-example/rag-with-custom-chunker/)
- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
