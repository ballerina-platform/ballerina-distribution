# Querying with streams

If stream terminates with `error`, result of `query expression` is an `error`. You cannot use `foreach`
on `stream` type with termination type that allows `error`. Instead use `from` with `do` clause; the
result is a subtype of `error?`. Use `stream` keyword in front of `from` to create a `stream` which is
lazily evaluated. The failure of `check` within the `query` will cause the `stream` to produce an
`error` termination value.

::: code querying_with_streams.bal :::

::: out querying_with_streams.out :::