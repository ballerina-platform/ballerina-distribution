# Strands

By default, named workers are multitasked cooperatively, not preemptively. Each named worker has a "strand" (logical thread of control) and execution switches between strands only at specific "yield" points such as doing a wait or when a library function invokes a system call that would block. This avoids the need for users to lock variables that are accessed from multiple named workers.
An annotation can be used to make a strand run on a separate thread.

::: code strands.bal :::

::: out strands.out :::