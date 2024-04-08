# Fork

The fork statement starts with one or more named workers, which run in parallel with each other, each in its own new strand. Variables and parameters in the scope of the fork statement remain within the scope of the workers. Message passing can be done only between the workers created within the fork statement and cannot be done with the function's default worker and its named workers. Unlike named workers, the `fork` keyword can be used to define workers anywhere within the function body.

::: code fork.bal :::

::: out fork.out :::
