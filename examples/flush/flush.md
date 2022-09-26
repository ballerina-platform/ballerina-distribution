# Flush

The `flush` action is used by the workers to check whether all the messages sent to a given worker are successfully recovered or not. If the transmission fails with an `error` or a `panic`, then, the error will be propagated to the waiting strand. Otherwise, it will return `nil`.

::: code flush.bal :::

::: out flush.out :::