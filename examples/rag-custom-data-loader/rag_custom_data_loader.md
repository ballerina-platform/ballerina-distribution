# Load using a custom data loader

The built-in `ai:TextDataLoader` loads local files, and modules such as [ballerinax/ai.microsoft.sharepoint](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest) load from external services. To load documents from another source, such as a database or an API, implement the `ai:DataLoader` type. Its single `load` method returns an `ai:Document` or an array of `ai:Document` values. You can then ingest these documents into a knowledge base like any others.

This example implements a data loader that turns support ticket records into `ai:TextDocument` values, with the ticket ID as metadata.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_data_loader.bal :::

::: out rag_custom_data_loader.out :::

## Related links

- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Load documents from multiple sources example](/learn/by-example/rag-document-sources/)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
