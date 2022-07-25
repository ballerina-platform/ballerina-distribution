# Panics

Ballerina distinguishes normal errors from abnormal errors. Normal errors are handled by returning error values. Abnormal errors are handled using the `panic` statement. Abnormal errors should typically result in immediate program termination (e.g., a programming bug or out-of-memory error). Panic has an associated error value. 

The `trap` expression stops a panic and gives access to the error value associated with the panic.

::: code panics.bal :::

::: out panics.out :::