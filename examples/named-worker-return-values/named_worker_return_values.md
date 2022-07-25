# Named worker return values

Named workers have a return type, which defaults to nil. A `return` statement in a named worker terminates the worker, not the function. Similarly, when `check` is used and the expression evaluates to an `error`, the `error` value is returned terminating the worker. Waiting on a named worker will give its return value.

::: code named_worker_return_values.bal :::

::: out named_worker_return_values.out :::