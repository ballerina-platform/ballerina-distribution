# Agentic retrieval-augmented generation (RAG) with WSO2 Cloud

The `ballerinax/ai.wso2.integration` module provides `wso2:CloudKnowledgeBase`, an `ai:KnowledgeBase` implementation backed by a knowledge base hosted on the WSO2 Integration platform. The documents are ingested and indexed on the platform, so the application only retrieves from it. Calls to `ingest` and `deleteByFilter` return an error.

Because it implements `ai:KnowledgeBase`, retrieval is exposed to an agent as a tool in the same way as any other knowledge base. The agent then decides whether to search, what to search for, and can search several times before answering, which is what distinguishes agentic RAG from a fixed retrieve-then-generate flow.

The knowledge base accepts a bearer token or OAuth2 client credentials, and can drop weak matches with `minSimilarityThreshold`. It also supports reranking the retrieved chunks with Cohere through the `cohereRerankerApiKey`, `cohereRerankerModel`, and `rerankerTopN` parameters.

> Note: Add the knowledge base URL and token to the `Config.toml` file. This example also uses the default model provider implementation. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest).

::: code agentic_rag_with_wso2_integration_knowledge_base.bal :::

## Related links
- [The Retrieve from a WSO2 Cloud knowledge base example](/learn/by-example/rag-wso2-cloud-knowledge-base-retrieval/)
- [The Agentic RAG with Pinecone example](/learn/by-example/agentic-rag-with-pinecone-vector-store/)
- [The `ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest)
