# Load documents from multiple sources

A retrieval-augmented generation (RAG) knowledge base often gets documents from more than one place. The `ai:DataLoader` type represents any source of documents.

This example loads documents from local files, a SharePoint document library, and memory.

To load from another source, see the [Load using a custom data loader](/learn/by-example/rag-custom-data-loader/) example.

> Note: This example requires a Microsoft Entra ID app registration with the `Sites.Read.All` application permission for Microsoft Graph. Add the token URL, client ID, client secret, and SharePoint site ID to the `Config.toml` file (e.g., `tokenUrl = "https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token"`, `siteId = "contoso.sharepoint.com:/sites/HR"`). The example loads the PDF and Markdown files in the `Policies` folder of the site's `Documents` library.

For more information on the underlying module, see the [`ballerinax/ai.microsoft.sharepoint` module](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest).

::: code rag_document_sources.bal :::

::: out rag_document_sources.out :::

## Related links

- [Sample leave policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-sources/leave_policy.pdf)
- [Sample employee handbook document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-sources/employee_handbook.md)
- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Load using a custom data loader example](/learn/by-example/rag-custom-data-loader/)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The `ballerinax/ai.microsoft.sharepoint` module](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest)
