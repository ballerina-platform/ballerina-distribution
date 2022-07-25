# Errors

Ballerina does not have exceptions. Errors are reported by functions returning `error` values and are immutable. `error` is its own basic type.

The return type `T` of a function that may return an `error` value will be a union with `error`, `T|error`.
An `error` value includes a `string` message and also the stack trace from the point at which the error is constructed (i.e., `error(msg)` is called).

::: code error_reporting.bal :::

::: out error_reporting.out :::