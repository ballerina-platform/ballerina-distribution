# Implement a custom chunker

The built-in chunkers split documents by structure and size. When your documents have a domain-specific structure, such as FAQ entries or log records, implement the `ai:Chunker` type. Its single `chunk` method takes an `ai:Document` and returns `ai:Chunk` values. You can call `chunk` directly, or pass the chunker to an `ai:VectorKnowledgeBase`, as shown in the [Ingest with a configured chunker](/learn/by-example/rag-with-configured-chunker/) example.

This example implements a chunker that splits an FAQ document into one chunk per question-and-answer pair and stores the question as metadata.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_custom_chunker.bal :::

::: out rag_with_custom_chunker.out :::

## Related links

- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Ingest with a configured chunker example](/learn/by-example/rag-with-configured-chunker/)
- [The Ingest without chunking example](/learn/by-example/rag-without-chunking/)
