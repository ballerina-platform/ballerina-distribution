# Implement a custom vector store

If you need more control over how vectors are stored and searched, for example to use your own database or your own search logic, implement the `ai:VectorStore` type yourself. Implement its three methods: `add` to save entries, `query` to return the entries that match a query, and `delete` to remove entries by ID. You can then use your vector store in a knowledge base like any other.

This example implements a vector store that saves entries to a JSON file, ranks them by cosine similarity, and supports `==` and `!=` metadata filters.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_vector_store.bal :::

::: out rag_custom_vector_store.out :::

## Related links

- [The Vector store operations example](/learn/by-example/rag-vector-store-operations/)
- [The Implement a custom embedding provider example](/learn/by-example/rag-custom-embedding-provider/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
