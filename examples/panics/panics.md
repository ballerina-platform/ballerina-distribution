# Panics

Ballerina distinguishes normal errors from abnormal errors. (E.g., A programming bug or out of memory.) Normal errors are handled by returning error values. Abnormal errors are handled using the panic statement. Abnormal errors should typically result in immediate program termination. A panic has an associated error value. Since program terminates, it is not needed to include error type in function return like in `check` expression

E.g., A programming bug or out of memory. A panic has an associated error value.

::: code panics.bal :::

::: out panics.out :::

## Related Links
- [Errors](https://ballerina.io/learn/by-example/error-reporting/)
- [Error handling](https://ballerina.io/learn/by-example/error-handling/)
- [Trap](https://ballerina.io/learn/by-example/trap/)
- [Checkpanic](https://ballerina.io/learn/by-example/checkpanic/)