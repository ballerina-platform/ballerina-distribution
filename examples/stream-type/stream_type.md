# Stream type

A `stream` represents a sequence of values that are generated as needed. The end of a `stream` is indicated with a termination value, which is `error` or `nil`. The `stream<T,E>`  type is a `stream` in which the members of the sequence are type `T` and the termination value is type `E`. `stream<T>` means `stream<T,()>`. The `stream` type is a separate basic type but it is like an object.

::: code stream_type.bal :::

::: out stream_type.out :::