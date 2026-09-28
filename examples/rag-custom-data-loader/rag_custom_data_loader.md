# Load using a custom data loader

The built-in `ai:TextDataLoader` loads local files, and modules such as [ballerinax/ai.microsoft.sharepoint](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest) load from external services. To load documents from any other source for a retrieval-augmented generation (RAG) knowledge base, such as a database, an API, or a ticketing system, implement the `ai:DataLoader` type yourself.

An `ai:DataLoader` has a single `load` method that returns an `ai:Document` or an array of `ai:Document` values. Return `ai:TextDocument` values with the text to be chunked and embedded, and add metadata, such as a record identifier, that is useful when the document is retrieved later. Because the custom loader produces the same `ai:Document` values as the built-in loaders, its documents can be combined with documents from other sources and ingested into a knowledge base.

This example demonstrates a custom data loader that turns support ticket records into text documents.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_data_loader.bal :::

::: out rag_custom_data_loader.out :::

## Related links

- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Load documents from multiple sources example](/learn/by-example/rag-document-sources/)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
