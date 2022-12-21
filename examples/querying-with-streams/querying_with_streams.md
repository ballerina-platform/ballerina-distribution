# Querying with streams

Query expression can be used to iteratively call the `next()` method of a stream. Binding pattern in query expression will bind the value of the result from the `next()` operation on the stream. If stream terminates with error, result of query expression is an error.

::: code querying_with_streams.bal :::

::: out querying_with_streams.out :::

## Related links
- [Manipulating an array `(lang.array)` - Language library](https://lib.ballerina.io/ballerina/lang.array)
