# Waiting for workers

Named workers can continue to execute after the function's default worker terminates and the function returns. A worker (function or named) can use `wait` to wait for a named worker.

::: code waiting_for_workers.bal :::

::: out waiting_for_workers.out :::