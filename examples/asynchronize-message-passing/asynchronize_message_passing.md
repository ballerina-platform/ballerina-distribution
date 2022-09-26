# Async send

Use `-> W` to send a message asynchronously to a `W` worker.  These messages should be of the `anydata` type. The sending worker will send all messages even though the receiving worker panics or returns an error.

::: code async_send.bal :::

::: out async_send.out :::