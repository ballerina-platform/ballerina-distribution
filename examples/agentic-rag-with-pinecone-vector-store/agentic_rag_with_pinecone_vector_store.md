# Agentic RAG with Pinecone

In the usual RAG flow, the application retrieves context and then calls the LLM, so exactly one retrieval happens per question. In agentic RAG, retrieval is exposed to an agent as a tool. The agent decides whether to retrieve, what query to retrieve with, and can retrieve several times before answering, which suits questions that span more than one part of the knowledge base.

This example connects to a Pinecone index through an `ai:VectorKnowledgeBase`, exposes its `retrieve` method as an `@ai:AgentTool`, and gives that tool to an `ai:Agent`.

> Prerequisite: Run the [Ingest into Pinecone](/learn/by-example/rag-ingestion-with-external-vector-store/) example first. It loads the sample leave policy document into the Pinecone index that this example queries.

> Note: This example uses the default model and embedding provider implementations and Pinecone. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Follow [`ballerinax/ai.pinecone` prerequisites](https://central.ballerina.io/ballerinax/ai.pinecone/latest#prerequisites) to extract the Pinecone configuration. The embedding provider used here must be the one used for ingestion.

For more information on the underlying module, see the [`ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest).

::: code agentic_rag_with_pinecone_vector_store.bal :::

::: out agentic_rag_with_pinecone_vector_store.out :::

## Related links
- [The Ingest into Pinecone example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
