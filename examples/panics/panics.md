# Panics

Ballerina distinguishes normal errors from abnormal errors.
Normal errors are handled by returning error values.
Abnormal errors are handled using the panic statement.
Abnormal errors should typically result in immediate program termination.
e.g., A programming bug or out of memory.
A panic has an associated error value.

::: code panics.bal :::

::: out panics.out :::