# Errors

Ballerina does not have exceptions. Errors are reported by functions returning
`error` values.
`error` is its own basic type.
The return type of a function that may return an `error` value will be a union with `error`.
An `error` value includes a `string` message.
An `error` value includes the stack trace from the point at which the error is constructed (i.e., `error(msg)` is called). 
Error values are immutable.

::: code error_reporting.bal :::

::: out error_reporting.out :::