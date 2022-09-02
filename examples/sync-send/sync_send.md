# Sync send

Use `->> W` to send a message synchronously to worker `W`. These messages should be of `anydata` type. Unlike asynchronous send, synchronous send will wait until the message is delivered. Synchronous send will return nil if the message was successful to the receiver or will return an error or panic based on the receiving worker’s state.

::: code sync_send.bal :::

::: out sync_send.out :::