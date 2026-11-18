# Load documents for retrieval-augmented generation (RAG)

Loading source documents is the first step of a retrieval-augmented generation (RAG) ingestion workflow. Ballerina provides the `ai:DataLoader` abstraction to load documents from various sources as `ai:Document` values, which can then be chunked, embedded, and indexed in a knowledge base.

The built-in `ai:TextDataLoader` loads files as `ai:TextDocument`s and supports the `pdf`, `docx`, `markdown`, `html`, and `pptx` file types. Additional data loaders are available for external sources, such as [ballerinax/ai.microsoft.sharepoint](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest) for Microsoft SharePoint.

This example demonstrates how to load documents of different file types using `ai:TextDataLoader` and inspect the loaded documents and their metadata.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_document_loading.bal :::

::: out rag_document_loading.out :::

## Related links

- [Sample employee handbook document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-loading/employee_handbook.md)
- [Sample leave policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-loading/leave_policy.pdf)
- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.microsoft.sharepoint` module](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest)
