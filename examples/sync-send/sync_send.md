# Sync send

Use `->> W` to send a message synchronously to the `W` worker. These messages should be of the `anydata` type. Unlike asynchronous send, synchronous send will wait until the message is delivered. If the transmission fails with an `error` or a `panic`, then, the error will be propagated to the waiting strand. Otherwise, it will return `nil`.

::: code sync_send.bal :::

::: out sync_send.out :::