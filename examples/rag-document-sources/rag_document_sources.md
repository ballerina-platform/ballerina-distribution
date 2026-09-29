# Load documents from multiple sources

The documents for a retrieval-augmented generation (RAG) knowledge base rarely come from a single place. The `ai:DataLoader` abstraction represents any source of documents: the built-in `ai:TextDataLoader` loads local files (`pdf`, `docx`, `markdown`, `html`, and `pptx`), and modules such as [ballerinax/ai.microsoft.sharepoint](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest) load documents from external services. Content that is already in memory, such as an HTTP response body, can be wrapped as an `ai:TextDocument` directly. To load from any other source, implement the `ai:DataLoader` type, as shown in the [Load using a custom data loader](/learn/by-example/rag-custom-data-loader/) example.

The `sharepoint:TextDataLoader` reads files from SharePoint document libraries, and optionally site pages, through the Microsoft Graph API. It loads text files, such as Markdown, as they are and extracts the text of PDF files. It authenticates with OAuth2 client credentials, a refresh token, or a bearer token. Each source names a site and the libraries, paths, and file extensions to load.

Because every loader produces `ai:Document` values, documents from different sources can be combined and ingested into a knowledge base together.

This example demonstrates loading documents from local files, from a SharePoint document library, and from in-memory content.

> Note: This example requires a Microsoft Entra ID app registration with the `Sites.Read.All` application permission for Microsoft Graph. Add the tenant ID, client ID, client secret, and SharePoint site ID to the `Config.toml` file (e.g., `siteId = "contoso.sharepoint.com:/sites/HR"`). The example loads the PDF and Markdown files in the `Policies` folder of the site's `Documents` library.

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
