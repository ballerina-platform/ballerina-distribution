# Filter results by metadata

Ballerina provides the `ai:KnowledgeBase` type for retrieval-augmented generation (RAG), and the `ai:VectorKnowledgeBase` implementation of it. Chunks carry metadata (`ai:Metadata`), with predefined fields such as the file name and custom fields. The `retrieve` method accepts metadata filters (`ai:MetadataFilters`) that add exact conditions on this metadata to the vector search. Each `ai:MetadataFilter` has a key, an operator (such as `ai:EQUAL`, `ai:IN`, or `ai:GREATER_THAN_OR_EQUAL`), and a value. Filters can be combined with `ai:AND` or `ai:OR`, and the same filters work with `deleteByFilter`.

This example ingests chunks with custom metadata, retrieves with and without filters, combines filters, and deletes chunks by filter.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_query_with_metadata_filters.bal :::

::: out rag_query_with_metadata_filters.out :::

## Related links

- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
