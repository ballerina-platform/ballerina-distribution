# Errors

Ballerina does not have exceptions. Instead functions report invalid states by returning error values. Each error value has,
1. Message, a human-readable `string` value describing the error.
2. Cause, which is an `error` value if this error was caused due to another error, which needs to be propagated, otherwise nil.
3. Detail, a mapping value consisting of additional information about the error.
4. Stack trace, a snapshot of the state of the execution stack when the error value was created.

Error values are immutable.

You can create a new error value using an error constructor. As the first argument to the error constructor, it expects the message string. As the second argument, you can optionally pass in an `error?` value for cause. Subsequent named arguments, if specified, will be used to create the detail mapping. The stack trace is provided by the runtime.

::: code error_reporting.bal :::

::: out error_reporting.out :::

## Related links
- [Error subtyping](https://ballerina.io/learn/by-example/error-subtyping/)
- [Error cause](https://ballerina.io/learn/by-example/error-cause/)
- [Error detail](https://ballerina.io/learn/by-example/error-detail/)
