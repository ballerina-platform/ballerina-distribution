# Implement a custom vector store

A vector store (`ai:VectorStore`) saves vector entries and searches them by similarity. The `ballerina/ai` module provides `ai:InMemoryVectorStore`, and modules such as [ballerinax/ai.pgvector](https://central.ballerina.io/ballerinax/ai.pgvector/latest) and [ballerinax/ai.pinecone](https://central.ballerina.io/ballerinax/ai.pinecone/latest) provide implementations for external databases. To keep the vectors in a database or search service that has no vector store module, implement the `ai:VectorStore` type yourself.

An `ai:VectorStore` has three methods: `add`, which saves vector entries, `query`, which returns the entries that match an `ai:VectorStoreQuery`, and `delete`, which removes entries by their IDs. A query has an embedding, metadata filters, or both, plus a `topK` limit, where `-1` returns all the entries. An `ai:VectorKnowledgeBase` adds entries without IDs, so a store should generate an ID when an entry does not have one. A custom store can be passed to an `ai:VectorKnowledgeBase`, which uses it to store and search the embedded chunks.

This example demonstrates a vector store that saves the entries to a JSON file, so they are available across runs. It ranks the entries by cosine similarity and supports metadata filters that use the `==` and `!=` operators. To keep the example self-contained, the embeddings are short, hand-written vectors.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_vector_store.bal :::

::: out rag_custom_vector_store.out :::

## Related links

- [The Vector store operations example](/learn/by-example/rag-vector-store-operations/)
- [The Implement a custom embedding provider example](/learn/by-example/rag-custom-embedding-provider/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
