# Named workers and futures

Futures and workers are the same thing. A reference to a named worker can be implicitly converted into a `future`. `start` is sugar for calling a function with a named worker and returning the named worker as a `future`. Cancellation of futures only happens at yield points.

::: code named_workers_and_futures.bal :::

::: out named_workers_and_futures.out :::