# Stream type

A `stream` represents a sequence of values that are generated as needed. The end of a `stream` is indicated with a
termination value, which is `error` or `nil`. The type `stream<T,E>` is a `stream` where the members of the
sequence are type `T` and termination value is type `E`. `stream<T>` means `stream<T,()>`. The `stream` type
is a separate basic type, but like an object.

::: code stream_type.bal :::

::: out stream_type.out :::