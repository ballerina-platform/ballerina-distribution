# Fork

The fork statement starts one or more named workers, which run in parallel with each other, each in its own new strand. Variables and parameters in scope for the fork-stmt remain in scope within the workers. Message passing can be done between the workers created within the fork statement and cannot be done between the function's default worker and its named workers.

::: code fork.bal :::

::: out fork.out :::
