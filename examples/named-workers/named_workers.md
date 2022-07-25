# Named workers

Normally, all of a function's code belong to the function's default worker, which has a single logical thread of control. A function can also declare named workers, which run concurrently with the function's default worker and other named workers.
Code before any named workers are executed before named workers start. Variables declared before all named workers and function parameters are accessible by named workers.

::: code named_workers.bal :::

::: out named_workers.out :::