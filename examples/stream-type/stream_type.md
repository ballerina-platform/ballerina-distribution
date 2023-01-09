# Stream type

A stream represents a sequence of values that are generated as needed. The end of a stream is indicated with a 
termination value, which is error or nil. The type `stream<T,E>` is a stream of which the members of the sequence 
are of the type `T`, and the termination value is type `E`. `stream<T>` means `stream<T,()>`.

The stream type is a separate basic type, However like an object, it can be initialized with a `new` expression by 
passing an object, which implements the `next() returns record{| T value; |}|C` method where `C` is either `()`, `error` or `error?`.

::: code stream_type.bal :::

::: out stream_type.out :::

## Related links
- [Create streams with query expression - Ballerina by example](/learn/by-example/create-streams-with-query)
- [Querying with streams - Ballerina by example](/learn/by-example/querying-with-streams)
