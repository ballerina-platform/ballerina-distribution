# Strands

By default, named workers are multitasked cooperatively, not preemptively. Each named worker has a "strand" (logical thread of control) and execution switches between strands only at specific "yield" points such as doing a wait or when a library function invokes a system call that would block.

::: code strands.bal :::

::: out strands.out :::