# Querying with streams

If a stream terminates with `error`, the result of the query expression is an `error`. You cannot use `foreach` on a `stream` type with a termination type that allows `error`. Instead, use `from` with the `do` clause where the result is a subtype of `error?`. Use the `stream` keyword in front of `from` to create a `stream`, which is lazily evaluated. The failure of `check` within the query will cause the `stream` to produce an `error` termination value.

::: code querying_with_streams.bal :::

::: out querying_with_streams.out :::