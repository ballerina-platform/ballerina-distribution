# Async send

Use `-> W` to send a message asynchronously to a `W` worker.  These messages should be of the `anydata` type. The sending worker will send all messages even though the receiving worker panics or returns an error.

::: code asynchronize_message_passing.bal :::

::: out asynchronize_message_passing.out :::
