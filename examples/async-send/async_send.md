# Async send

Use `-> W` to send a message asynchronously to worker `W`.  These messages should be of `anydata` type. Sending worker will send all messages even though the receiving worker panics or returns an error.

::: code async_send.bal :::

::: out async_send.out :::