# Errors
In Ballerina invalid states are represented by `error` values. Each error value has,
1. Message, a human-readable `string` describing the error.
2. Cause, which is an `error` value if this error was caused by another error, otherwise nil.
3. Detail, a mapping value which can be used to provide additional information about the error.
4. Stack trace, a snapshot of the state of the execution stack when the error value was created.

Error values are immutable. 

You can create new error values by calling the error constructor. As the first argument to the error constructor, it expects the `message` string. As the second argument, you can optionally pass in an `error?` value for cause. The remaining named arguments will be used to create the detail record. The stack trace is provided by the runtime.

::: code error_reporting.bal :::

::: out error_reporting.out :::

## Related links
- [Error subtyping](https://ballerina.io/learn/by-example/error-subtyping/)
- [Error cause](https://ballerina.io/learn/by-example/error-cause/)
- [Error detail](https://ballerina.io/learn/by-example/error-detail/)
