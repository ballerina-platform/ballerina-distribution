# Agentic retrieval-augmented generation (RAG) with WSO2 Cloud

The `ballerinax/ai.wso2.integration` module provides `wso2:CloudKnowledgeBase`, an `ai:KnowledgeBase` backed by a knowledge base on the [WSO2 Integration Platform](https://wso2.com/integration-platform/docs/). Documents are ingested on the platform, so the application only retrieves from it. The `ingest` and `deleteByFilter` methods are not supported yet. In agentic RAG, retrieval is a tool, so the agent decides whether and what to search, and can search several times.

This example gives an agent a tool that searches the knowledge base and drops weak matches with `minSimilarityThreshold`.

> Note: Add the knowledge base URL and token to the `Config.toml` file. This example also uses the default model provider implementation. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest).

::: code agentic_rag_with_wso2_integration_knowledge_base.bal :::

## Related links
- [The Retrieve from a WSO2 Cloud knowledge base example](/learn/by-example/rag-wso2-cloud-knowledge-base-retrieval/)
- [The Agentic RAG with Pinecone example](/learn/by-example/agentic-rag-with-pinecone-vector-store/)
- [The `ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest)
- [WSO2 Integration Platform documentation](https://wso2.com/integration-platform/docs/)
