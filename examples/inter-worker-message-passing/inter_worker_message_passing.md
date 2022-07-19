# Inter-worker message passing

Use `-> W` or `<- W` to send a message to or receive a message from worker `W` (use `function` to refer to the function's default worker). The messages are copied using [clone()](https://lib.ballerina.io/ballerina/lang.value/0.0.0/functions#clone). It implies immutable values are passed without a copy. Message sends and receives are paired up at compile time. Each pair turns into a horizontal line in the sequence diagram. Easy to use and safe, but limited expressiveness.

::: code inter_worker_message_passing.bal :::

::: out inter_worker_message_passing.out :::