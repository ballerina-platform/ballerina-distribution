# Panics

Ballerina distinguishes normal errors from abnormal errors (e.g., a programming bug or an out-of-memory error). Normal errors are handled by returning error values. Abnormal errors are handled using the panic statement. Abnormal errors should typically result in immediate program termination. Panic has an associated error value. Since the program terminates, it is not needed to include the error type in the function return like in the `check` expression.

E.g., A programming bug or an out-of-memory error. Panic has an associated error value.

::: code panics.bal :::

::: out panics.out :::

## Related Links
- [Errors](https://ballerina.io/learn/by-example/error-reporting/)
- [Error handling](https://ballerina.io/learn/by-example/error-handling/)
- [Trap](https://ballerina.io/learn/by-example/trap/)
- [Checkpanic](https://ballerina.io/learn/by-example/checkpanic/)